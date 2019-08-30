//
//  DatabaseHelper.swift
//  CoreDataProject
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static let sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private init(){}
    
    //MARK: Create
    func create(objectOf object: [String:Any]) -> Bool {
        let itemObject = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context!) as! Item
        itemObject.itemName = object["itemName"] as? String
        itemObject.isChecked = (object["isChecked"] as? Bool)!
        
        do{
            try context?.save()
            print("Data Saved Successfully")
            return true
        }catch{
            print("Error saving data")
            return false
        }
    }
    
    //MARK: Fetch
    func fetchDataFromEntity(fromEntity entity: String, withPredicate predicate: NSPredicate?, withSortDescriptor sortDescriptor: NSSortDescriptor?) -> [NSManagedObject] {
        var allItems = [NSManagedObject]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        if let predicateValue = predicate, let sortDescriptorValue = sortDescriptor {
            fetchRequest.predicate = predicateValue
            fetchRequest.sortDescriptors = [sortDescriptorValue]
        }
        
        do {
            allItems = try (context?.fetch(fetchRequest))!
        }catch {
            print("Not able to fetch data from store")
        }
        return allItems
    }
    
    //MARK: Delete from Index
    func delete(atIndex index: Int) -> [NSManagedObject] {
        
        var allItem = fetchDataFromEntity(fromEntity: "Item", withPredicate: nil, withSortDescriptor: nil)
        context?.delete(allItem[index]) // Remove data from Entity
        allItem.remove(at: index) // Remove data from Array
        
        do{
            try context?.save()
            print("Data Saved Successfully")
        }catch{
            print("Error Deleting data")
        }
        
        return allItem
    }
    
    //MARK: Update
    func update(objectOf object: Item, atIndex i: Int) {
        var allItem = fetchDataFromEntity(fromEntity: "Item", withPredicate: nil, withSortDescriptor: nil) as! [Item]
        allItem[i] = object
        do{
            try context?.save()
            print("Data Edited Successfully")
        }catch{
            print("Error Editing data")
        }
        
    }
}
