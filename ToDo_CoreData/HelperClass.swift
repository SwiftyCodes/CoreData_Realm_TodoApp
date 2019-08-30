//
//  Extensions.swift
//  ToDo_CoreData
//
//  Created by Anurag Kashyap on 30/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import UIKit

class HelperClass {
    
    static var sharedInstance = HelperClass()
    private init() {}
    
    //MARK: Alert TextField
    func alertWithTextField(alertTitle title: String, alertMessage message : String, actionTitle actiontitle: String, textFieldPlaceholder placeholder:String, onCompletion: @escaping(String) -> Void) -> UIAlertController{
        var addedItem = UITextField()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actiontitle, style: .default) { (action) in
            onCompletion(addedItem.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in}
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = placeholder
            addedItem = alertTextField
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        return alert
    }
    
}
