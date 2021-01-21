//
//  ListViewController.swift
//  FoodList
//
//  Created by Neria Jerafi on 19/01/2021.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK:-Properties
    @IBOutlet weak var foodTableView: UITableView!
    private var tableController:TableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableController = TableController(tableView: foodTableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            guard let destinationVC = segue.destination as? AddFoodViewController else { return}
            destinationVC.delegate = self
        }
    }
}

// MARK: AddFoodViewController delegate method
extension ListViewController:AddFoodViewControllerDelegate{
    func updateTable() {
        tableController?.loadDataFromDB()
    }
    
    
}



