//
//  Question.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    
    @objc dynamic var question: String      = ""
    @objc dynamic var answer: String        = ""
    @objc dynamic var hint: String          = ""
    @objc dynamic var category: String      = ""
    
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "questions")
}
