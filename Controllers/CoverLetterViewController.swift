//
//  CoverLetterViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit

class CoverLetterViewController: UIViewController {
    //MARK:- Class Properties
    
    //MARK:- IBOutlets
    @IBOutlet weak var includeSwitch: UISwitch!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addressedToTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension CoverLetterViewController{
    
    fileprivate func initialSetup(){
        
        bodyTextView.layer.borderWidth = 0.5
        bodyTextView.layer.cornerRadius = 10
        dateTextField.layer.cornerRadius = 10
        addressedToTextField.layer.cornerRadius = 10
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Cover Letter"
        
        if AppManager.shared.resumeData.coverLetterData != nil {
            
            dateTextField.text = AppManager.shared.resumeData.coverLetterData?.date
            addressedToTextField.text = AppManager.shared.resumeData.coverLetterData?.addressedTo
            bodyTextView.text = AppManager.shared.resumeData.coverLetterData?.body
            
        }
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if bodyTextView.text != "" && dateTextField.text != "" && addressedToTextField.text != "" {
            
            let coverLetterData = CoverLetterModel(includeSwitch: includeSwitch.state.rawValue, date: dateTextField.text ?? "", addressedTo: addressedToTextField.text ?? "", body: bodyTextView.text ?? "")
            AppManager.shared.resumeData.coverLetterData = coverLetterData
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        else {
            
            bodyTextView.showError(textView: bodyTextView)
            dateTextField.showError(textField: dateTextField)
            addressedToTextField.showError(textField: addressedToTextField)
        }
    }
}
