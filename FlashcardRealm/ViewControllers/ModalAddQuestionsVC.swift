//
//  ModalAddQuestionsVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 13/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

protocol RefreshDataDelegate {
    func refreshData()
}


class ModalAddQuestionsVC: UIViewController {
    let realm = try! Realm()

    @IBOutlet weak var questionTextfield: UITextField!
    @IBOutlet weak var answerTextfield: UITextField!
    @IBOutlet weak var hintTextfield: UITextField!
    
    var selectedCategory: Category?
    var delegate: RefreshDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addQustion(_ sender: UIButton) {
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
