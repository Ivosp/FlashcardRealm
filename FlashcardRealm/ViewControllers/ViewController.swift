//
//  ViewController.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

