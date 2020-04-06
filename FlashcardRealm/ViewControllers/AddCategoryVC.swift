//
//  AddCategoryVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class AddCategoryVC: UIViewController {
    
    let realm = try! Realm()
    dynamic var categories: Results<Category>?
    var existingCategory = [Results<Category>]()
    var categoryNames = [Any]()


    @IBOutlet weak var categoryTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCategoryToDB(_ sender: UIButton) {
            
        
        
        if let newCategory = categoryTextfield.text {
            
            existingCategory.removeAll()
            
            let predicate = NSPredicate(format: "categoryName = %@", newCategory)
            if let predResults = categories?.filter(predicate) {
                existingCategory.insert(predResults, at: 0)
                print(existingCategory.description.contains(newCategory))
            }
            
            if existingCategory.description.contains(newCategory) == false {
                
                let categoryToBeAdded = Category()
                categoryToBeAdded.categoryName = newCategory
                saveData(category: categoryToBeAdded)
                categoryTextfield.text = ""
            } else {
                categoryTextfield.text          = ""
                categoryTextfield.placeholder   = "You already had this category."
            }
        }
    }
    
    
    
    func saveData(category: Category) {

            do {
                try realm.write {
                    realm.add(category, update: .modified)
                    print("Successfully added Category")
                }
            } catch {
                print("error saving context \(error)")
            }
        }
    
    
    func loadData() {
        
        categories = realm.objects(Category.self).sorted(byKeyPath: "categoryName")
        
        
    }
}
