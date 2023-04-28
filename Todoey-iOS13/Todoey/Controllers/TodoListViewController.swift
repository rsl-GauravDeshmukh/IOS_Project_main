//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray:[Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory:Category? {
        didSet {
            let request:NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
            request.sortDescriptors = [NSSortDescriptor(key: "parentCategory.name", ascending: true)]
            loadData(with:request)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
    }
    
    
    // MARK: -  TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.font  = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.text = item.title
        // Use of Ternary Operatior
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        saveData()
        tableView.reloadData()
        
    }
    
    
    // MARK: - Add Bar Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            let newItem = Item(context: self.context)
            newItem.title =  textField.text!
            newItem.done  = false
            newItem.parentCategory = self.selectedCategory!
            self.itemArray.append(newItem)
            self.saveData()
            self.tableView.reloadData()
        }
        
        
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create  new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Model Manupulation Methods

    private func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    
    private func loadData(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [additionalPredicate,categoryPredicate])
            request.predicate = compoundPredicate
        }
        
        else {
            request.predicate = categoryPredicate
        }
        do {
            itemArray = try context.fetch(request)
            
        } catch {
            print("Error in fetching the data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    private func deletecategory(with index:Int) {
        
    }

}

// MARK: - SearchBar Methods
extension TodoListViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text?.count == 0) {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
    
// MARK: - lifeCycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
}
