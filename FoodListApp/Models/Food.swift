//
//  Food.swift
//  FoodList
//
//  Created by Neria Jerafi on 20/01/2021.
//

import Foundation
import RealmSwift

// MARK: Food model for Realm DB
class Food:Object {
    @objc dynamic var foodName:String = ""
    @objc dynamic var foodDescription:String = ""
    @objc dynamic var foodImage:Data?
    @objc dynamic var FoodRating:Double = 0.0
}
