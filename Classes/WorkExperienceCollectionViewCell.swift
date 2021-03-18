//
//  workExperienceTVCell.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import Foundation
import UIKit

protocol WorkExperienceCollectionViewCellDelegate {
    
    func didTapOnButton(cell: WorkExperienceCollectionViewCell)
}

class WorkExperienceCollectionViewCell: UICollectionViewCell {

//MARK:- Class Properties
    
    var cellDelegate: WorkExperienceCollectionViewCellDelegate?
    
//MARK:- IBOutlets
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var accomplishmentTextView: UITextView!
}

//MARK:- Class Methods
    
extension WorkExperienceCollectionViewCell {
    
    func configureCell(workExperience: WorkPlaceDetailsModel, index: IndexPath) {
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10

            positionTextField.text = workExperience.position
            subtitleTextField.text = workExperience.subtitle
            durationTextField.text = workExperience.date
            
            workExperience.accomplishment?.forEach({ (accomplishment) in
                accomplishmentTextView.text += accomplishment + "\n"
            })
        
    }
}

//MARK:- IBActions
extension WorkExperienceCollectionViewCell {
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        self.positionTextField.text = ""
        self.subtitleTextField.text = ""
        self.durationTextField.text = ""
        self.accomplishmentTextView.text = ""
        
        cellDelegate?.didTapOnButton(cell: self)
    }
}
