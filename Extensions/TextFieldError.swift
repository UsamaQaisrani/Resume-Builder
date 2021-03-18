//
//  ShowError.swift
//  Resume Builder
//
//  Created by Usama on 18/03/2021.
//

import Foundation
import UIKit


extension UITextField: UITextFieldDelegate {
    
    func showError(textField: UITextField){
        if textField.text?.isEmpty == true{
            
            textField.layer.cornerRadius = 10
            textField.layer.borderWidth = 0.5
            textField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
        }
    }
}
