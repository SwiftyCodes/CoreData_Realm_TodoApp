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

    var toDoListArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        let alertController = HelperClass.sharedInstance.alertWithTextField(alertTitle: "Add new item to Todoey", alertMessage: "", actionTitle: "Add", onCompletion: { textFieldValue in
            self.toDoListArray.append(textFieldValue)
            self.todoeyTableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
    
}

extension TodoListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
           tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TodoListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.textLabel?.text = toDoListArray[indexPath.row]
        return cell
    }
}

