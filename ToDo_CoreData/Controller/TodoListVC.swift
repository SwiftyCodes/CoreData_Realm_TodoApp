//
//  ViewController.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import CoreData

class TodoListVC: UIViewController {
    
    @IBOutlet weak var todoeyTableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var toDoListArray : [NSManagedObject] = []
    var filteredListArray : [NSManagedObject] = []
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Item", withPredicate: nil, withSortDescriptor: nil)
    }
    
    //MARK: Button Actions
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        let alertController = HelperClass.sharedInstance.alertWithTextField(alertTitle: "Add new item to Todoey", alertMessage: "", actionTitle: "Add", textFieldPlaceholder: "Create a new Todoey", onCompletion: { textFieldValue in
            let dictItemValues = ["itemName":textFieldValue,"isChecked":false] as [String : Any]
            if DatabaseHelper.sharedInstance.create(objectOf: dictItemValues){
                self.toDoListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Item", withPredicate: nil, withSortDescriptor: nil)
                self.todoeyTableView.reloadData()
            }
        })
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: Datasource
extension TodoListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarOutlet.text == ""{
            return toDoListArray.count
        }else{
            return filteredListArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        var item = Item()
        
        if searchBarOutlet.text == ""{
            item = toDoListArray[indexPath.row] as! Item
        }else{
            item = filteredListArray[indexPath.row] as! Item
        }

        cell.toDoValue = item
        //Ternary Operator
        //Value = condition ? TrueValue : FalseValue - Works for a boolean check
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
}

//MARK: Delegate
extension TodoListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = Item()
        
        if searchBarOutlet.text == ""{
            item = toDoListArray[indexPath.row] as! Item
        }else{
            item = filteredListArray[indexPath.row] as! Item
        }
        
        item.isChecked = !item.isChecked
        //tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) // for animation
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:

            if searchBarOutlet.text == ""{
                toDoListArray = DatabaseHelper.sharedInstance.delete(atIndex: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}

extension TodoListVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!) //Query
        let sortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)// Sorting
        filteredListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Item", withPredicate: predicate, withSortDescriptor: sortDescriptor)
        todoeyTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            toDoListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Item", withPredicate: nil, withSortDescriptor: nil)
            todoeyTableView.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            let predicate = NSPredicate(format: "itemName CONTAINS[cd] %@", searchBar.text!) //Query
            let sortDescriptor = NSSortDescriptor(key: "itemName", ascending: true)// Sorting
            filteredListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Item", withPredicate: predicate, withSortDescriptor: sortDescriptor)
            todoeyTableView.reloadData()
        }
    }
}
