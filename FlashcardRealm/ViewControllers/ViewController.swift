//
//  ViewController.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {
    
// MARK: - Outlets
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    // ButtonOutlets
    @IBOutlet weak var addNewQuestionBtn: UIButton!
    @IBOutlet weak var addNewCategoryBtn: UIButton!
    @IBOutlet weak var lookAtDataBtn: UIButton!
    @IBOutlet weak var learnBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Flashcards!"
//        titleLabel.charInterval = 0.08
        // Do any additional setup after loading the view.
        backGroundImageView.image = UIImage(named: "OnTheGoImage")
        backGroundImageView.alpha = 0.4
        
        setupButtons(for: addNewQuestionBtn, color: Constants.Colors.FifthColor, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold)
        setupButtons(for: addNewCategoryBtn, color: Constants.Colors.FifthColor, withAlpha: 1, roundedCorners: true, textSize: 20, textWeight: .semibold)
        setupButtons(for: lookAtDataBtn, color: Constants.Colors.FifthColor, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold)
        setupButtons(for: learnBtn, color: Constants.Colors.FifthColor, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold)
    }
    
    func setupButtons(for button: UIButton, color: UIColor, withAlpha alpha: CGFloat, roundedCorners: Bool, textSize: CGFloat, textWeight: UIFont.Weight) {
        
        button.backgroundColor = color.withAlphaComponent(alpha)
        
        switch roundedCorners {
        case true:
            button.layer.cornerRadius = 10
        case false:
            button.layer.cornerRadius = 0
        }
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func learnCategory(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.LearnCategorySegue, sender: self)
    }
    
    @IBAction func addNewCategory(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.AddCategorySegue, sender: self)
    }
    
    @IBAction func addQuestionsToCategory(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.MenuToAddQuestionsSegue, sender: self)
    }
    
    @IBAction func lookAtData(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.MenuToDataSegue, sender: self)
    }
    
}

