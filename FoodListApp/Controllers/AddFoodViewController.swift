//
//  AddFoodViewController.swift
//  FoodList
//
//  Created by Neria Jerafi on 19/01/2021.
//

import UIKit
import Cosmos
import RealmSwift


protocol AddFoodViewControllerDelegate:class {
    func updateTable()
}

class AddFoodViewController: UIViewController,UINavigationControllerDelegate {
    
    //MARK:- Properties
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var foodDescriptionTextField: UITextField!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodRatingView: CosmosView!
    weak var delegate:AddFoodViewControllerDelegate?
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodRatingView.settingsForStart(updateOnTouch: true, starSize: 40)
        imageViewSetup()
    }
    
    // MARK: Image view setup
    private func imageViewSetup() {
        foodImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(recognizer:)))
        foodImageView.addGestureRecognizer(tap)
    }
    @objc private func didTapImageView(recognizer:UITapGestureRecognizer){
        showAlert()
    }
    
    //MARK: Alert controller for selection source
    private func showAlert(){
        let alert = UIAlertController(title: Constants.alertTitle, message: Constants.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertCameraButtonTitle, style: .default, handler: { (action) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: Constants.alertPhotoLibraryButtonTitle, style: .default, handler: { (action) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: Constants.alertCancelButtonTitle, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Get image from source type
    private func getImage(fromSourceType sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    // MARK: Create Food Object
    private func createFood() -> Food? {
        guard let name = foodNameTextField.text, !name.isEmpty,
              let description = foodDescriptionTextField.text , !description.isEmpty,
              let imageData = foodImageView.image?.jpegData(compressionQuality: 0.5)
        else { return nil }
        let food = Food()
        food.foodName = name
        food.foodDescription = description
        food.foodImage = imageData
        food.FoodRating = foodRatingView.rating
        return food
    }
    
    //MARK: Save to Realm DB
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let food = createFood() else { return}
        do {
            try realm.write{
                realm.add(food)
            }
        } catch  {
            print(error.localizedDescription)
        }
        delegate?.updateTable()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
// MARK: ImagePickerController delegate methods
extension AddFoodViewController:UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            foodImageView.image = image
            foodImageView.backgroundColor = .clear
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


