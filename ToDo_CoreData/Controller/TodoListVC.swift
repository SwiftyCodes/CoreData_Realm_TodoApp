//
//  ViewController.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController {

    var toDoListArray = ["Buy Fruits","Buy Vegitables","Buy Cake"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

