//
//  AddHabitViewController.swift
//  Habitual2
//
//  Created by Cao Mai on 5/26/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pickPhotoButtonPressed: UIButton!
    
    let habitImages = Habit.Images.allCases
    
    var selectedIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let selectedIndexPath = selectedIndexPath {
                indexPaths.append(selectedIndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: indexPaths)
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HabitImageCollectionViewCell.nib, forCellWithReuseIdentifier: HabitImageCollectionViewCell.identifier)
        setupNavBar()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickPhotoButtonPressed(_ sender: Any) {
           guard let selectedIndexPath = selectedIndexPath else {return}
           let confirmHabitVC = ConfirmHabitViewController.instantiate()
           confirmHabitVC.habitImage = habitImages[selectedIndexPath.row]
           navigationController?.pushViewController(confirmHabitVC, animated: true)
       }
    
    
    func setupNavBar() {
        title = "Select Image"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddHabit(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    @objc func cancelAddHabit(_ sender: UIBarButtonItem) {
        
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


extension AddHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImageCollectionViewCell.identifier, for: indexPath) as! HabitImageCollectionViewCell
        
        if indexPath == selectedIndexPath {
            cell.setImage(image: habitImages[indexPath.row].image, withSelection: true)
        } else {
            // Error withSElection!!!
            cell.setImage(image: habitImages[indexPath.row].image, withSelection: false)
        }
        
        //        cell.setImage(image: habitImages[indexPath.row].image)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/4, height: collectionViewWidth/4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        return false
    }
    
}
