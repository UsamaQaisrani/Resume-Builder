//
//  ReferencesViewController.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import UIKit

class ReferencesViewController: UIViewController {
    
    //MARK:- Class Properties
    
    let referenceInfo = AppManager.shared.resumeData.referenceData
    
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
            
            contentTextView.text = referenceInfo?.content
            titleTextField.text = referenceInfo?.title
        }
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if contentTextView.text.isEmpty == false && titleTextField.text?.isEmpty == false {
            
            let referencesModel = ReferencesModel(title: titleTextField.text ?? "", content: contentTextView.text ?? "", bulletPointSwitch: bulletPointSwitch.state.rawValue)
            AppManager.shared.resumeData.referenceData = referencesModel
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        else {
            
            contentTextView.showError(textView: contentTextView)
            titleTextField.showError(textField: titleTextField)
        }
    }
}
