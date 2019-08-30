//
//  ViewController.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController {
    
    @IBOutlet weak var todoeyTableView: UITableView!

    var toDoListArray : [ItemModel] = []
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Button Actions
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        let alertController = HelperClass.sharedInstance.alertWithTextField(alertTitle: "Add new item to Todoey", alertMessage: "", actionTitle: "Add", textFieldPlaceholder: "Create a new Todoey", onCompletion: { textFieldValue in
            let newItem = ItemModel()
            newItem.itemName = textFieldValue
            self.toDoListArray.append(newItem)
            self.todoeyTableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: Datasource
extension TodoListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        let item = toDoListArray[indexPath.row]
        cell.textLabel?.text = item.itemName
        //Ternary Operator
        //Value = condition ? TrueValue : FalseValue - Works for a boolean check
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
}

//MARK: Delegate
extension TodoListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDoListArray[indexPath.row].isChecked = !toDoListArray[indexPath.row].isChecked
        //tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true) // for animation
    }
}
