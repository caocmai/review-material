//
//  ConfirmHabitViewController.swift
//  Habitual2
//
//  Created by Cao Mai on 5/26/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    @IBOutlet weak var habitImageView: UIImageView!
    @IBOutlet weak var habitNameInputField: UITextField!
    
    var habitImage: Habit.Images!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
           title = "New Habit"
           habitImageView.image = habitImage.image
       }


    @IBAction func createHabitButtonPressed(_ sender: Any) {
        // Checking if texfield is empty
        guard let text = habitNameInputField.text, !text.isEmpty else { return print("Field can't be EMPTY!!") }
        
        var persistenceLayer = PersistanceLayer()
        guard let habitText = habitNameInputField.text else { return }
        persistenceLayer.createNewHabit(name: habitText, image: habitImage)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
