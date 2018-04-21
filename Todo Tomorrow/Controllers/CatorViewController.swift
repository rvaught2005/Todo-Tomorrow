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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Data Manipulation Methods
    
    func saveCator() {
        do {
            try.context.save()
        } catch {
            self.tableView.reloadData()
        }
        
    }
    
    func loadCator() {
        do {
            catorArray = try context.fetch()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
}
