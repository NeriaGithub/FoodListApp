//
//  CosmosViewExtension.swift
//  FoodList
//
//  Created by Neria Jerafi on 20/01/2021.
//

import Foundation
import Cosmos

extension CosmosView{
    func settingsForStart(updateOnTouch:Bool = false, starSize:Double = 30) {
        self.settings.fillMode = .half
        self.settings.updateOnTouch = updateOnTouch
        self.settings.starSize = starSize
        self.settings.totalStars = 5
        self.settings.minTouchRating = 0
        self.rating = 0
    }
}
