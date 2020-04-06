//
//  Constants.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import Foundation

struct Constants {
    
    struct DatabaseNames {
        static let primaryKey               = "categoryName"
    }
    
    struct Segues {
        
        static let AddCategorySegue         = "AddNewCategorySegue"
        static let MenuToAddQuestionsSegue  = "MenuToAddQuestionsVC"
        static let MenuToDataSegue          = "LookAtDataSegue"
    }
    
    struct CategoryTableView {
        
        static let CategoryCell             = "CategoryCell"
        
    }
    
    struct QuestionsTableView {
        
    }
    
}
