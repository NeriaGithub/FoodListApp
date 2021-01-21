//
//  TableController.swift
//  FoodList
//
//  Created by Neria Jerafi on 20/01/2021.
//

import Foundation
import UIKit
import SwipeCellKit
import RealmSwift

class TableController: NSObject {
    
    // MARK: Properties
    private var tableView:UITableView
    private let realm = try! Realm()
    private var foodList:Results<Food>?
    
    init(tableView:UITableView) {
        self.tableView = tableView
        super.init()
        tableViewSetup()
        loadDataFromDB()
    }
    
    // MARK: Table view setup
    func tableViewSetup() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
    }
    
    // MARK: Realm DB methods
    func loadDataFromDB() {
        foodList =  realm.objects(Food.self)
        tableView.reloadData()
    }
    
    private func deleteFromDB(atRow row:Int){
        if let foodForDeletion = foodList?[row] {
            do {
                try realm.write{
                    realm.delete(foodForDeletion)
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
}



// MARK: Tableview datasource delegate methods
extension TableController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! FoodCell
        cell.setCell(withFood: foodList?[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: SwipeTableViewCell delegate methods
extension TableController:SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: Constants.deleteCellActionTitle) { [weak self] (action, indexPath) in
            guard let strongSelf = self else { return}
            strongSelf.deleteFromDB(atRow: indexPath.row)
        }
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
