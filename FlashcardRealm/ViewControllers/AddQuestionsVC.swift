//
//  AddQuestionsVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class AddQuestionsVC: UIViewController {
    
    let realm = try! Realm()
    dynamic var categories: Results<Category>?
    
    var selectedCategory : Category?
    
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var questionTextfield: UITextField!
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var hintTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        // Do any additional setup after loading the view.
        
        // Categorypicker delegation
        categoryPicker.delegate     = self
        categoryPicker.dataSource   = self
        categoryPicker.reloadAllComponents()
        
        // Textfield Delegation
        questionTextfield.delegate  = self
        answerTextfield.delegate    = self
        hintTextfield.delegate      = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        categoryPicker.selectRow(0, inComponent: 0, animated: true)
        pickerView(categoryPicker, didSelectRow: 0, inComponent: 0)
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self).sorted(byKeyPath: "categoryName", ascending: true)
    }
    
    
    @IBAction func submitQuestion(_ sender: Any?) {
        
        if let question = questionTextfield.text, let answer = answerTextfield.text, let hint = hintTextfield.text {
            
            do {
                try! realm.write {
                    let newQuestion = Question()
                    newQuestion.question    = question
                    newQuestion.answer      = answer
                    newQuestion.hint        = hint
                    newQuestion.category    = selectedCategory?.categoryName as! String
                    newQuestion.dateCreated = Date()
                    selectedCategory?.questions.append(newQuestion)
                    print("Successfully saved question!")
                    questionTextfield.text = ""
                    answerTextfield.text = ""
                    hintTextfield.text = ""
                }
                
            } catch {
                print("Error saving data \(error)")
            }
        }
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

extension AddQuestionsVC: UIPickerViewDelegate, UIPickerViewDataSource {

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
            return "No categories added yet."
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if categories?.isEmpty == false {
            selectedCategory = categories?[row]
            print(selectedCategory)
        } else {
            return
        }
    }


}

extension AddQuestionsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.questionTextfield {
            textField.resignFirstResponder()
            answerTextfield.becomeFirstResponder()
        } else if textField == self.answerTextfield {
            textField.resignFirstResponder()
            hintTextfield.becomeFirstResponder()
        } else if textField == self.hintTextfield {
            submitQuestion(nil)
            textField.resignFirstResponder()
        }
        return true
    }
}
