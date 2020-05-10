//
//  TestMenuController.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 24/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class TestMenuController: UIViewController {
    
    // Outlets
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var questionOrderSegmentControl: UISegmentedControl!
    @IBOutlet weak var testYourselfBtn: UIButton!
    
    // variables and constants
    let realm = try! Realm()
    dynamic var categories: Results<Category>?
    
    var selectedCategory: Category?
    var categoryQuestionCount = 0
    
    var questionsToTestCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

        // Do any additional setup after loading the view.
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.reloadAllComponents()
        
        questionCountLabel.text = "\(questionsToTestCount)"
        questionOrderSegmentControl.backgroundColor = .systemIndigo
        testYourselfBtn.tintColor = .systemIndigo
        
        print(questionOrderSegmentControl.titleForSegment(at: questionOrderSegmentControl.selectedSegmentIndex)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        categoryPickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView(categoryPickerView, didSelectRow: 0, inComponent: 0)
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
    }
    
    @IBAction func questionOrderSegmentControlAction(_ sender: UISegmentedControl) {
        print(sender.titleForSegment(at: sender.selectedSegmentIndex))
        
    }
    
    @IBAction func questionCountStepper(_ sender: UIStepper) {
        sender.minimumValue = 0
        sender.maximumValue = Double(categoryQuestionCount)
        
        questionsToTestCount = Int(sender.value)
        questionCountLabel.text = "\(questionsToTestCount)"
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TestVC
        
        if let category = selectedCategory {
            
            destinationVC.selectedCategory = category
            destinationVC.questionCount = questionsToTestCount
            
            
        }
        
        
        
    }
    

    @IBAction func testYourselfBtn(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.TestSegue, sender: self)
    }
}


extension TestMenuController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if let category = categories?[row] {
            return category.categoryName
        } else {
            return "Please enter a Data first!"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if categories?.isEmpty == false {
            selectedCategory = categories?[row]
            var categoryName = selectedCategory?.categoryName
            categoryQuestionCount = selectedCategory?.questions.count as! Int
            print(categoryName!, categoryQuestionCount)
        } else {
            return
        }
    }
    
    
}
