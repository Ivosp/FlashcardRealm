//
//  QuestionsDataVC.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 13/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift

class QuestionsDataVC: UIViewController, RefreshDataDelegate {
    
     // MARK: - Delegate Methods from ModalAddQuestionsVC
    func refreshData() {
        questionsTableView.reloadData()
    }
    
    // MARK: - Constants, Variables and Outlets
    let realm = try! Realm()
    
    var questions: Results<Question>?
    var selectedCategory: Category? {
        didSet {
            loadQuestions()
        }
    }
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
        
        questionsTableView.register(UINib(nibName: Constants.QuestionsTableView.QuestionCell, bundle: nil), forCellReuseIdentifier: Constants.QuestionsTableView.QuestionCell)
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        questionsTableView.reloadData()
        // Do any additional setup after loading the view.
        
        title = "Questions - \(selectedCategory?.categoryName ?? "Test")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("View Will Appear")
        questionsTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ModalAddQuestionsVC
        destinationVC.selectedCategory = selectedCategory!
        destinationVC.delegate = self
    }
    
    // MARK: - IBActions
    @IBAction func addQuestion(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.Segues.AddQuestionSegue, sender: self)
        
    }
    
    // MARK: - General Methods
    func loadQuestions() {
        questions = selectedCategory?.questions.sorted(byKeyPath: "dateCreated", ascending: true)
       
    }
    
}

// MARK: - TableviewDelegate and DataSource methods
extension QuestionsDataVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfQuestions = 0
        
        if let questionCount = questions?.count {
            if questionCount == 0 {
                numberOfQuestions = 1
            } else {
                numberOfQuestions = questionCount
            }
        }
        return numberOfQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.QuestionsTableView.QuestionCell, for: indexPath) as! QuestionsCell
        
        if questions?.isEmpty == false {

            if let question = questions?[indexPath.row] {
                cell.questionLabel.text = "Question: \(question.question)"
                cell.answerLabel.text = "A: \(question.answer)"
                cell.answerLabel.isHidden = false
                
                if question.hint.isEmpty == true {
                    cell.hintLabel.isHidden = true
                } else {
                    cell.hintLabel.isHidden = false
                    cell.hintLabel.text = "H: \(question.hint)"
                }
            }
        } else if questions?.isEmpty == true {
            cell.questionLabel.text = "Please enter a question"
            cell.questionLabel.isHighlighted = true
            cell.answerLabel.isHidden = true
            cell.hintLabel.isHidden = true
        }
        return cell
    }
    
    
}
