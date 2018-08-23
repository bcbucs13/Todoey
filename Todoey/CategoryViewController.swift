//
//  CategoryViewController.swift
//  Todoey
//
//  Created by user on 8/20/18.
//  Copyright © 2018 Bradley Carter. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Categories.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "categoryCell")
        cell.textLabel?.text = category.name
        return cell
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToItemsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    
    //save & load data
    //loads items from our CoreData databse
    //Internal and external parameter and has default value of Item.fetchRequest()
    //MARK: - Data Manipulation Methods
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
       
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loadingCategories \(error)")
        }
    }
    
    func saveCategories() {
        do {
            try self.context.save()
        } catch {
            print ("error = \(error)")
        }
        self.tableView.reloadData()
    }

    
    
    


}
