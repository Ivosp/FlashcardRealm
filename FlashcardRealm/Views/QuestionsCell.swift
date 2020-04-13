//
//  QuestionsCell.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 13/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit

class QuestionsCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
