//
//  ReferencesViewController.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import UIKit

class ReferencesViewController: UIViewController {
    
    //MARK:- Class Properties
    
    //MARK:- IBOutlets
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bulletPointSwitch: UISwitch!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
}

//MARK:- Class Methods
extension ReferencesViewController {
    
    fileprivate func initialSetup(){
        
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.cornerRadius = 10
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "References"
        
        if AppManager.shared.resumeData.referenceData != nil {
            
            contentTextView.text = AppManager.shared.resumeData.referenceData?.content
            titleTextField.text = AppManager.shared.resumeData.referenceData?.title
            
        }
        
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if contentTextView.text != "" && titleTextField.text != "" {
            
            let referencesModel = ReferencesModel(title: titleTextField.text ?? "", content: contentTextView.text ?? "", bulletPointSwitch: bulletPointSwitch.state.rawValue)
            AppManager.shared.resumeData.referenceData = referencesModel
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        else {
            
            if contentTextView.text == "" {
                
                self.contentTextView.layer.borderWidth = 0.5
                self.contentTextView.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
            
            if titleTextField.text == "" {
                
                self.titleTextField.layer.borderWidth = 0.5
                self.titleTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
            
        }
    }
}

//MARK:- IBActions
extension ReferencesViewController {
    
    
    
}
