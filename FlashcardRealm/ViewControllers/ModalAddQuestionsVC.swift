//
//  ModalAddQuestionsVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 13/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

protocol RefreshDataDelegate {
    func refreshData()
}


class ModalAddQuestionsVC: UIViewController{
    let realm = try! Realm()

    @IBOutlet weak var questionTextfield: UITextField!
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var hintTextfield: UITextField!
    
    var selectedCategory: Category?
    var delegate: RefreshDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextfield.delegate = self
        answerTextfield.delegate = self
        hintTextfield.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addQustion(_ sender: UIButton?) {
        
        if let question = questionTextfield.text, let answer = answerTextfield.text, let hint = hintTextfield.text, let category = selectedCategory?.categoryName {
            
            do {
                try! realm.write {
                    
                    let newQuestion = Question()
                    newQuestion.category = category
                    newQuestion.question = question
                    newQuestion.answer = answer
                    newQuestion.hint = hint
                    newQuestion.dateCreated = Date()
                    
                    selectedCategory?.questions.append(newQuestion)
                    
                    dismiss(animated: true, completion: nil)
                    self.delegate?.refreshData()
                }
            } catch {
                print(error)
            }
            
        }
        
    }
    
}


extension ModalAddQuestionsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.questionTextfield {
            textField.resignFirstResponder()
            answerTextfield.becomeFirstResponder()
        } else if textField == self.answerTextfield {
            textField.resignFirstResponder()
            hintTextfield.becomeFirstResponder()
        } else if textField == self.hintTextfield {
            addQustion(nil)
            textField.resignFirstResponder()
        }
        return true
    }
}
