//
//  QualificationViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit

class QualificationViewController: UIViewController {
    
    //MARK:- Class Properties
    
    var qualificationsArray: [String.SubSequence]?
    let qualificationsInfo = AppManager.shared.resumeData.qualificationsData
    
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

extension QualificationViewController{
    
    fileprivate func initialSetup(){
        
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.cornerRadius = 10
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Objective"
        
        if qualificationsInfo != nil {
            
            contentTextView.text = ""
            qualificationsInfo?.content?.forEach({ (content) in
                contentTextView.text += content + "\n"
            })
            titleTextField.text = qualificationsInfo?.title
        }
        
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if contentTextView.text != "" && titleTextField.text != "" {
            
            
            qualificationsArray = contentTextView.text.split(separator: "\n")
            let qualificationData = QualificationsModel(title: titleTextField.text ?? "", content: qualificationsArray ?? [String.SubSequence](), bulletPointSwitch: bulletPointSwitch.state.rawValue)
            AppManager.shared.resumeData.qualificationsData = qualificationData
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        else{
            
            contentTextView.showError(textView: contentTextView)
            titleTextField.showError(textField: titleTextField)
        }
    }
}
