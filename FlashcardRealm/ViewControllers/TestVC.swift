//
//  TestVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 10/05/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class TestVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var questionView: UIView!
 
    @IBOutlet weak var qTwoLabel: UILabel!
    @IBOutlet weak var qOneLabel: UILabel!
    
    // Constants and Variables
    let realm = try! Realm()
    var questions: Results<Question>?
    var questionArray = [Question]()
    
    var questionCount = 0
    var progressCount = 0
    var selectedCategory: Category? {
        didSet{
            loadQuestions()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let shadowSize: CGFloat = 10
//        let contactRect = CGRect(x: -shadowSize, y: questionView.frame.height - (shadowSize * 0.4) + 40, width: questionView.frame.width + shadowSize * 2, height: shadowSize)
//        questionView.layer.shadowPath = UIBezierPath(rect: contactRect).cgPath
        
        questionView.layer.shadowColor = UIColor.systemGray.cgColor
        

        questionView.layer.shadowOpacity = 0.5
        questionView.layer.shadowOffset = .zero
        questionView.layer.shadowRadius = 5
        
        
    }
    

    
    
    func loadQuestions() {
           questions = selectedCategory?.questions.sorted(byKeyPath: "dateCreated")
           
           if let count = questions?.count {
               questionCount = count
           }
           
       
       }
    
    
    @IBAction func flipForward(_ sender: UIButton) {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: questionView, duration: 1.0, options: transitionOptions, animations: {
            
        })
        
//        UIView.transition(with: questionView, duration: 1.0, options: transitionOptions, animations: {
//            self.questionView.isHidden = true
//            print("t 1")
//        })
//
//        UIView.transition(with: nextQuestionView, duration: 1.0, options: transitionOptions, animations: {
//            self.nextQuestionView.isHidden = false
//            print("t2")
//        })
        
        
    }
    
    @IBAction func flipBack(_ sender: Any) {
        
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft]
        
        UIView.transition(with: questionView, duration: 1.0, options: transitionOptions, animations: {
//            self.questionView.isHidden = false
//            self.nextQuestionView.isHidden = true
        })
        
        
        //UIView.transition(from: nextQuestionView, to: questionView, duration: 1.0, options: transitionOptions)
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
