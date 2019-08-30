//
//  TodoTableViewCell.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var toDoNameLabel: UILabel!
    
    var toDoValue : Item? {
        didSet{
            configureCell()
        }
    }
    
    func configureCell(){
        toDoNameLabel.text = toDoValue?.itemName
    }
}
