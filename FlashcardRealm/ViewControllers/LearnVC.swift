//
//  TestYourselfVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 16/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class LearnVC: UIViewController {
    
    // Constants and Variables
    let realm = try! Realm()
    var questions: Results<Question>?
    var questionArray = [Question]()

    var categoryString = ""
    var questionCount = 0
    var progressCount = 0
    
    var selectedCategory: Category? {
        didSet {
            loadQuestions()
        }
    }
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var nextQuestionBtn: UIButton!
    
    // Outlets in Subview
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    // Constraints Outlet of Questionview
    @IBOutlet weak var questionLabelTopConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        progressCount = 1
        
        questionLabelTopConstraint.constant = questionView.frame.height / 2
        
        questionView.layer.shadowRadius = 10
        questionView.layer.shadowColor = UIColor.systemOrange.cgColor
        questionView.layer.shadowOffset = .zero
        questionView.layer.opacity = 1
        questionView
            .layer.masksToBounds = false
        
        if let cat = selectedCategory?.categoryName {
            categoryString = cat
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
        }
        
        // Checks whether questioncount is over 0 - if true, append each questionObject to Array to make iterable.
        if questionCount != 0 {
            for i in 0...questionCount - 1 {
                
                if let question = questions?[i] {
                    questionArray.append(question)
                }
            }
            questionLabel.text = questionArray[0].question
            hintLabel.text = questionArray[0].hint
            answerLabel.text = questionArray[0].answer
            
        } else {
            questionLabel.text = "Please enter data into this Category first."
        }
        
        
        print(questionArray)
       
        hintLabel.isHidden = true
        answerLabel.isHidden = true
        // Do any additional setup after loading the view.
                
    }
    
    func loadQuestions() {
        questions = selectedCategory?.questions.sorted(byKeyPath: "dateCreated")
        
        if let count = questions?.count {
            questionCount = count
        }
        
    
    }
    
    // Buttons
    @IBAction func showAnswerBtn(_ sender: UIButton) {
        answerLabel.isHidden = false
        questionLabelTopConstraint.constant = 50
        questionLabel.font = UIFont.systemFont(ofSize: 25)

    }
    
    @IBAction func showHintBtn(_ sender: UIButton) {
        hintLabel.isHidden = false
        questionLabelTopConstraint.constant = 50
        questionLabel.font = UIFont.systemFont(ofSize: 25)
    }
    
    @IBAction func nextQuestionBtn(_ sender: UIButton) {
        print(progressCount, questionCount)
        if progressCount < questionCount {
            progressCount += 1
            
            questionLabelTopConstraint.constant = questionView.frame.height / 2
            questionLabel.text = questionArray[progressCount - 1].question
            questionLabel.font = UIFont.systemFont(ofSize: 50)
            
            answerLabel.isHidden = true
            answerLabel.text = questionArray[progressCount - 1].answer
            
            hintLabel.isHidden = true
            hintLabel.text = questionArray[progressCount - 1].hint
            
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
            
        } else if progressCount == questionCount{

            self.progressCount = 1
            
            questionLabel.text = questionArray[progressCount - 1].question
            questionLabelTopConstraint.constant = questionView.frame.height / 2
            questionLabel.font = UIFont.systemFont(ofSize: 25)
            
            answerLabel.isHidden = true
            answerLabel.text = questionArray[progressCount - 1].answer
            
            hintLabel.isHidden = true
            hintLabel.text = questionArray[progressCount - 1].hint
            
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
            
        }
        
       
        
    }
}
