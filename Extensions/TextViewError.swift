//
//  TextViewError.swift
//  Resume Builder
//
//  Created by Usama on 18/03/2021.
//

import Foundation
import UIKit

extension UITextView: UITextViewDelegate {
    
    func showError(textView: UITextView){
        
        if textView.text.isEmpty == true{
            
            textView.layer.borderWidth = 0.5
            textView.layer.cornerRadius = 10
            textView.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
        }
    }
}
