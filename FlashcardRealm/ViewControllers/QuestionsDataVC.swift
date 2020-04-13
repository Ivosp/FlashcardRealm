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
    
    func refreshData() {
        questionsTableView.reloadData()
    }
    
    
    let realm = try! Realm()
    
    var questions: Results<Question>?
    var selectedCategory: Category? {
        didSet {
            loadQuestions()
        }
    }
    
    
    
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addQuestion(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.Segues.AddQuestionSegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ModalAddQuestionsVC
        destinationVC.selectedCategory = selectedCategory!
        destinationVC.delegate = self
    }
    
    func loadQuestions() {
        questions = selectedCategory?.questions.sorted(byKeyPath: "dateCreated", ascending: true)
       
    }
    
}

extension QuestionsDataVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.QuestionsTableView.QuestionCell, for: indexPath) as! QuestionsCell
        
        if let question = questions?[indexPath.row] {
            cell.questionLabel.text = "Question: \(question.question)"
            cell.answerLabel.text = "A: \(question.answer)"
            
            if question.hint.isEmpty == true {
                cell.hintLabel.isHidden = true
            } else {
                cell.hintLabel.text = "H: \(question.hint)"
            }
        } else if questions?.isEmpty == true {
            cell.questionLabel.text = "Please enter a question"
            cell.answerLabel.text = "Please commit to an answer"
            cell.hintLabel.text = "Duh."
        }
        
        return cell
    }
    
    
}