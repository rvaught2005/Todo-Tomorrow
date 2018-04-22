//
//  CatorViewController.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/20/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import UIKit
import CoreData

class CatorViewController: UITableViewController {

    var catorArray = [Cator]()
    //An array of Cator objects
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCator()
       
    }

    //MARK: Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField1 = UITextField()
        
        let alert1 = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Add Category", style: .default) {(action1) in
        
        print(textField1.text!)
        
            
            let newCator = Cator(context: self.context)
            newCator.name = textField1.text!
            self.catorArray.append(newCator)
            
            self.saveCator()
            print("Success")
            
        }
            alert1.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField1 = alertTextField
            
        }
        alert1.addAction(action1)
        present(alert1, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return catorArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "CatorCell", for: indexPath)
        
        let cator = catorArray[indexPath.row]
        
        cell1.textLabel?.text = cator.name
        
        return cell1
    }
  
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCator = catorArray[indexPath.row]
        }
    }
    //MARK: - Data Manipulation Methods
    
    func saveCator() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCator(with request: NSFetchRequest<Cator> = Cator.fetchRequest()) {
        do {
            catorArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
