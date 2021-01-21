//
//  FoodCell.swift
//  FoodList
//
//  Created by Neria Jerafi on 19/01/2021.
//

import UIKit
import Cosmos
import SwipeCellKit

class FoodCell: SwipeTableViewCell {

    //MARK:- Properties
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    @IBOutlet weak var foodRatingView: CosmosView!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foodRatingView.settingsForStart()
    }
    
    //MARK: Set food image view to nil when cell is reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        foodImageView.image = nil
    }

    //MARK: Set FoodCell
    func setCell(withFood foodData:Food?) {
        guard let food = foodData else { return  }
        foodNameLabel.text = food.foodName
        foodDescriptionLabel.text = food.foodDescription
        foodRatingView.rating = food.FoodRating
        if let imageData = food.foodImage {
            foodImageView.image = UIImage(data: imageData)
        }
    }
}




