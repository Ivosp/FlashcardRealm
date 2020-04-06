//
//  CategoriesDataVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 06/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesDataVC: UIViewController {
    
    let realm = try! Realm()
    dynamic var categories: Results<Category>?

    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCategoryButton(_ sender: UIButton) {
        
        var  textField = UITextField()
        
        let addAlert = UIAlertController(title: "New Category", message: "Add a new category: ", preferredStyle: .alert)
        
        let addCategoryAction = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if let newCategory = textField.text {
                
                
                if self.categories?.description.contains(newCategory) == false {
                    
                    let categoryToBeAdded = Category()
                    categoryToBeAdded.categoryName = newCategory
                    self.saveData(category: categoryToBeAdded)
                    textField.text = ""
                } else {
                    print("Already added this category")
                    textField.text          = ""
                    textField.placeholder   = "You already had this category."
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("No new category to be added")
            self.dismiss(animated: true, completion: nil)
        }
        
        addAlert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter a new Category"
            textField = alertTextfield
        }
        
        addAlert.addAction(addCategoryAction)
        addAlert.addAction(cancelAction)
        
        present(addAlert, animated: true, completion: nil)
                
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self).sorted(byKeyPath: Constants.DatabaseNames.primaryKey, ascending: true)
        tableView.reloadData()
        
    }
    
    func saveData(category: Category) {
        do {
            try! realm.write() {
                realm.add(category)
                print("Successfully added Category")
            }
        } catch {
            print("error saving context \(error)")
        }
        
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoriesDataVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CategoryTableView.CategoryCell, for: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.categoryName
        } else {
            cell.textLabel?.text = "Please enter a category"
        }
        
        if let categoryCount = categories?[indexPath.row].questions.count {
            cell.detailTextLabel?.text = "\(categoryCount) questions."
        } else {
            cell.detailTextLabel?.text = "Please enter questions"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
