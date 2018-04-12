//
//  TodoListViewController.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/8/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
 

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
//        let newItem1 = Item()
//        newItem1.title = "Find Mike"
//        itemArray.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "Find Mike"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Find Mike"
//        itemArray.append(newItem3)
 
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
        
        loadItems()
    }

   
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        // Value = condition ? valueTrue : valueFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        //OR  cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
//        cell.messageBody.text = messageArray[indexPath.row].messageBody
//        cell.senderUsername.text = messageArray[indexPath.row].sender
//        cell.avatarImageView.image = UIImage(named: "egg")
        // This might be useful in Image Oragnizer

        return cell
    }
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItms()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
 
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }

        print(itemArray[indexPath.row])
    
    }
    
    // MARK - Add new items
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert.
            print(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            // This was a learning example of how the data can be found while debugging.
            // Inserting a break at the above line of code will stop the program just before this line of code is executed.
            // In the debug console you can type print itemArray and it will show the three hard coded items from itemArray.
            // You can then click on the step over icon; which is the fourth item from the left above the adjacent pane to the left of the debug console.
            // At this point if you type print itemArray in the debug console again it will show the fourth item that has been appended to itemArray.
            
        
            
            self.saveItms()
            
            
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            //[User Defaults] Attempt to set a non-property-list object.
            //This is the extent of UserDefaults; the above message shows its limitations. It cannot save custom types or custom objects like the ones we have created.
            //At this point we have to abandon ship with UserDefaults!
            //WARNING: Don't use UserDefaults for anthing more complicated than a switch selcetion or a volume setting.
            
       
            
            
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
    
    //MARK - Model Manipulation Methods
    
    func saveItms() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            print(dataFilePath!)
        } catch {
            print("Error encoding itemArray, \(error)")
        }
        self.tableView.reloadData()
        // This line of code updates the table view to show the new data.
    }
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error encoding itemArray, \(error)")
            }
        }
    }
}

