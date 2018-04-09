//
//  TodoListViewController.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/8/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
 

    var itemArray = ["Find Mike", "Buy Eggs", "Fill out Application"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

   
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
//        cell.messageBody.text = messageArray[indexPath.row].messageBody
//        cell.senderUsername.text = messageArray[indexPath.row].sender
//        cell.avatarImageView.image = UIImage(named: "egg")
        // This might be useful in Image Oragnizer

        return cell
    }
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
 
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        print(itemArray[indexPath.row])
    
    }
    
    // MARK - Add new items
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert.
            print(textField.text!)
            self.itemArray.append(textField.text!)
            // This was a learning example of how the data can be found while debugging.
            // Inserting a break at the above line of code will stop the program just before this line of code is executed.
            // In the debug console you can type print itemArray and it will show the three hard coded items from itemArray.
            // You can then click on the step over icon; which is the fourth item from the left above the adjacent pane to the left of the debug console.
            // At this point if you type print itemArray in the debug console again it will show the fourth item that has been appended to itemArray.
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            // This line of code updates the table view to show the new data.
            
            print("Success")
        }
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            // print(alertTextField.text)
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

