//
//  HabitDetailViewController.swift
//  Habitual2
//
//  Created by Cao Mai on 5/26/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class HabitDetailedViewController: UIViewController {
    
    var detailHabit: Habit!
    var habitIndex: Int!
    
    private var persistence = PersistanceLayer()

    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelCurrentStreak: UILabel!
    @IBOutlet weak var labelTotalCompletions: UILabel!
    @IBOutlet weak var labelBestStreak: UILabel!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    @IBAction func pressActionButton(_ sender: Any) {
        detailHabit = persistence.markHabitAsCompleted(habitIndex)
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        title = detailHabit.title
        imageViewIcon.image = detailHabit.selectedImage.image
        labelCurrentStreak.text = "\(detailHabit.currentStreak) days"
        labelTotalCompletions.text = String(detailHabit.numberOfCompletions)
        labelBestStreak.text = String(detailHabit.bestStreak)
        labelStartingDate.text = detailHabit.dateCreated.stringValue

        if detailHabit.completedToday {
            buttonAction.setTitle("Completed for Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as Completed", for: .normal)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
