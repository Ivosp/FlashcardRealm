//
//  Category.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var categoryName = ""
    
    let questions = List<Question>()
    
    override class func primaryKey() -> String? {
        return "categoryName"
    }
    
}
