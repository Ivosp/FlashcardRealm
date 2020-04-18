//
//  TestYourselfCategoryPickerVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 15/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class LearnCategoryPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    
    // Outlets
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    // Constants and variables
    
    let realm = try! Realm()
    dynamic var categories: Results<Category>?
    
    
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        title = "Category to learn"
        
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryPicker.reloadAllComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        categoryPicker.selectRow(0, inComponent: 0, animated: true)
        pickerView(categoryPicker, didSelectRow: 0, inComponent: 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! LearnVC
        
        if let category = selectedCategory {
            destinationVC.selectedCategory = category
        }
        
    }
    

    
    // MARK: - General class functions
    
    func loadCategories() {
        categories = realm.objects(Category.self).sorted(byKeyPath: Constants.DatabaseNames.primaryKey, ascending: true)
    }
    
    // MARK: - Buttons
    @IBAction func testYourselfButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.LearnSegue, sender: self)
    }
    
    
    // MARK: - Pickerviewercomponents
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categories?.count ?? 1
       }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if categories?.isEmpty == false {
            selectedCategory = categories?[row]
        } else {
            return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let category = categories?[row] {
            return category.categoryName
        } else {
            return "Please enter a Data first!"
        }
    }

    
}
