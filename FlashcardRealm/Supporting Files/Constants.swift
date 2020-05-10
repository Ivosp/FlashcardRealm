//
//  Constants.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit

struct Constants {
    
    struct DatabaseNames {
        static let primaryKey                   = "categoryName"
    }
    
    struct Segues {
        
        static let AddCategorySegue             = "AddNewCategorySegue"
        static let MenuToAddQuestionsSegue      = "MenuToAddQuestionsVC"
        static let MenuToDataSegue              = "LookAtDataSegue"
        static let MentuToTestSegue             = "MenuToTestSegue"
        static let CategoriesToQuestionsSegue   = "CatToQuestionsSegue"
        static let AddQuestionSegue             = "AddQuestionSegue"
        static let LearnCategorySegue           = "LearnCategorySegue"
        static let LearnSegue                   = "LearnSegue"
        static let TestSegue                    = "TestSegue"
    }
    
    struct CategoryTableView {
        
        static let CategoryCell                 = "CategoryCell"
        
    }
    
    struct QuestionsTableView {
        static let QuestionCell                 = "QuestionsCell"
    }
    
    struct Colors {
        static let ImageBaseColor = UIColor(red: 30, green: 21, blue: 61, alpha: 1)
        static let SecondBaseColor = UIColor(red: 35, green: 67, blue: 95, alpha: 1)
        static let ThirdColor = UIColor(red: 113, green: 172, blue: 180, alpha: 1)
        static let FourthColor = UIColor(red: 183, green: 177, blue: 149, alpha: 1)
        static let FifthColor = UIColor(red: 222, green: 170, blue: 69, alpha: 1)
    }
    
}
