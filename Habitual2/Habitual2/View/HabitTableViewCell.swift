//
//  HabitTableViewCell.swift
//  Habitual2
//
//  Created by Cao Mai on 5/25/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    static let identifier = "HabitCell"
    
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Returning the xib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ habit: Habit) {
        self.imageViewIcon.image = habit.selectedImage.image
        self.labelHabitTitle.text = habit.title
        self.labelStreaks.text = "streak: \(habit.currentStreak)"

        if habit.completedToday {
          self.accessoryType = .checkmark
        } else {
         self.accessoryType = .disclosureIndicator
        }
    }
    
}
