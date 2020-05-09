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
    @IBOutlet weak var testBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.text = "Flashcards!"
        titleLabel.textColor = .systemIndigo
//        titleLabel.charInterval = 0.08
        // Do any additional setup after loading the view.
        backGroundImageView.image = UIImage(named: "OnTheGoImage")
        backGroundImageView.alpha = 0.4
        
        setupButtons(for: addNewQuestionBtn, color: .systemIndigo, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold, textColor: .white)
        setupButtons(for: addNewCategoryBtn, color: .systemIndigo, withAlpha: 1, roundedCorners: true, textSize: 20, textWeight: .semibold, textColor: .white)
        setupButtons(for: lookAtDataBtn, color: .systemIndigo, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold, textColor: .white)
        setupButtons(for: learnBtn, color: .systemIndigo, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold, textColor: .white)
        setupButtons(for: testBtn, color: .systemIndigo, withAlpha: 0.9, roundedCorners: true, textSize: 20, textWeight: .semibold, textColor: .white)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            titleLabel.textColor = .systemIndigo
        case .light:
            titleLabel.textColor = .systemIndigo
        case .unspecified:
            titleLabel.textColor = .systemIndigo
        @unknown default:
            fatalError("New mode. Find colors for it.")
        }
    }
    
    func setupButtons(for button: UIButton, color: UIColor, withAlpha alpha: CGFloat, roundedCorners: Bool, textSize: CGFloat, textWeight: UIFont.Weight, textColor: UIColor ) {
        
        button.backgroundColor = color.withAlphaComponent(alpha)
        
        switch roundedCorners {
        case true:
            button.layer.cornerRadius = 10
        case false:
            button.layer.cornerRadius = 0
        }
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: textSize, weight: textWeight)
        button.setTitleColor(textColor, for: .normal)
        
        
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
    
    @IBAction func testYourselfButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.MentuToTestSegue, sender: self)
    }
}

