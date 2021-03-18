//
//  EducationCollectionViewCell.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import UIKit

protocol EducationCollectionViewCellDelegate {
    func didTapOnButton(cell: EducationCollectionViewCell)
}

class EducationCollectionViewCell: UICollectionViewCell {

//MARK:- Class Properties
    
    var cellDelegate: EducationCollectionViewCellDelegate?
    
//MARK:- IBOutlets
    
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var accomplishmentTextView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
}
//MARK:- Class Methods

extension EducationCollectionViewCell {

    func configureCell(education: EducationPlaceDetailsModel){
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        
        degreeTextField.text = education.degree
        schoolTextField.text = education.school
        dateTextField.text = education.date
        
        education.accomplishment?.forEach({ (accomplishments) in
            accomplishmentTextView.text += accomplishments + "\n"
        })
        
    }
}

//MARK:- IBActions
extension EducationCollectionViewCell {
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        self.degreeTextField.text = ""
        self.schoolTextField.text = ""
        self.dateTextField.text = ""
        self.accomplishmentTextView.text = ""
        
        cellDelegate?.didTapOnButton(cell: self)
    }
}
