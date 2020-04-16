//
//  TestYourselfVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 16/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class TestYourselfVC: UIViewController {
    
    // Constants and Variables
    let realm = try! Realm()
    
    var questions: Results<Question>?
    var questionCount = 0
    
    var questionArray = [Question]()
    
    var selectedCategory: Category? {
        didSet {
            loadQuestions()
        }
    }
    
    var categoryString = ""
    var progressCount = 0
    
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    
    
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
        print(questions, questionCount)
        
        
        questionView.layer.shadowRadius = questionView.frame.height / 5
        questionView.layer.shadowColor = UIColor.systemOrange.cgColor
        questionView.layer.shadowOffset = CGSize(width: questionView.frame.width / 5, height: questionView.frame.height / 5)
        
        if let cat = selectedCategory?.categoryName {
            categoryString = cat
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
        }
        
        
        for i in 0...questionCount - 1 {
            
            if let question = questions?[i] {
                questionArray.append(question)
            }
        }
        
        print(questionArray)
        questionArray.shuffled()
        
        
        
        questionLabel.text = questionArray[progressCount].question
        hintLabel.text = questionArray[progressCount].hint
        answerLabel.text = questionArray[progressCount].answer
        
        hintLabel.isHidden = true
        answerLabel.isHidden = true
        // Do any additional setup after loading the view.
                
    }
    
    func loadQuestions() {
        questions = selectedCategory?.questions.sorted(byKeyPath: "question")
        
        if let count = questions?.count {
            questionCount = count
        }
        
    
    }
    
    // Buttons
    @IBAction func showAnswerBtn(_ sender: UIButton) {
        answerLabel.isHidden = false
        questionLabelTopConstraint.constant = 50
    }
    
    @IBAction func showHintBtn(_ sender: UIButton) {
        hintLabel.isHidden = false
        questionLabelTopConstraint.constant = 50
    }
    
    @IBAction func nextQuestionBtn(_ sender: UIButton) {
        print(progressCount, questionCount, questionArray.count)
        if progressCount < questionCount {
            progressCount += 1
            
            questionLabel.text = questionArray[progressCount - 1].question
            questionLabelTopConstraint.constant = questionView.frame.height / 2
            
            answerLabel.isHidden = true
            answerLabel.text = questionArray[progressCount - 1].answer
            
            hintLabel.isHidden = true
            hintLabel.text = questionArray[progressCount - 1].hint
            
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
            
        } else if progressCount == questionCount{
            self.progressCount = 1
            
            questionLabel.text = questionArray[progressCount - 1].question
            questionLabelTopConstraint.constant = questionView.frame.height / 2
            
            answerLabel.isHidden = true
            answerLabel.text = questionArray[progressCount - 1].answer
            
            hintLabel.isHidden = true
            hintLabel.text = questionArray[progressCount - 1].hint
            
            titleLabel.text = "\(categoryString) - \(progressCount) out of \(questionCount)"
            
        }
        
       
        
    }
}
