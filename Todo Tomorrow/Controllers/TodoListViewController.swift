//
//  TodoListViewController.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/8/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
 

    var itemArray = [Item]()
    
    var selectedCator: Cator? {
        didSet {
          
            loadItems()
        }
    }
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //With the line of code we are tapping into the UIApplication class, we are getting the shared singleton object, which corresponds to current app as an object, tapping into its delegate, which has the data type of an optional UIapplicationdelegate, and we are casting it into our class AppDelegate. Because they both inherit from the same supper class UIApplicationDelegate, this "UIApplication.shared.delegate as! AppDelegate" is perfectly valid; which enables us to have acces to our AppDelegate as an object. When we append "persistentContainer.viewContext" we find that Xcode predicts the property, persistentContainer, as well as the viewContext of that persistentContainer.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
         print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        
    }

   
    //MARK: - Tableview Datasource Methods
    
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
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        //Removing items from Core Data.
        //context.delete(itemArray[indexPath.row])
        //First, delete the temporary note of this item within the context; or scratchpad.
        //itemArray.remove(at: indexPath.row)
        //Remove item from the populated array called itemArray.
        
        saveItems()
        //Finally, save the changes.
        
        
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
    
    // MARK: - Add new items
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert.
            print(textField.text!)
            
        
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCator = self.selectedCator
            self.itemArray.append(newItem)
            // This was a learning example of how the data can be found while debugging.
            // Inserting a break at the above line of code will stop the program just before this line of code is executed.
            // In the debug console you can type print itemArray and it will show the three hard coded items from itemArray.
            // You can then click on the step over icon; which is the fourth item from the left above the adjacent pane to the left of the debug console.
            // At this point if you type print itemArray in the debug console again it will show the fourth item that has been appended to itemArray.
            
        
            
            self.saveItems()
            
            
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
    
    //MARK: - Model Manipulation Methods
    
    func saveItems() {
        
        do {
           try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
        // This line of code updates the table view to show the new data.
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    //The word "with" indicates an external parameter
    //=Item.fetchRequest() is the default value that is used if no request is specified
        
        let catorPredicate = NSPredicate(format: "parentCator.name MATCHES %@", selectedCator!.name!)
        
        if let additonalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catorPredicate, additonalPredicate])
        } else {
            request.predicate = catorPredicate
        }
        
        
        do {
           itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
   
}
//MARK: - Search bar methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        // [cd] makes the query insisative to case and diacritics.
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

