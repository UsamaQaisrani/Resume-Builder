//
//  ContactInfoViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit
import M13Checkbox


class ContactInfoViewController: UIViewController {
    
    //MARK:- Class Properties
    
    let contactInfo = AppManager.shared.resumeData.contactInfoData
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextFIeld: UITextField!
    
    //MARK:- Base Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension ContactInfoViewController {
    
    fileprivate func initialSetup(){
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Contact Info"
        
        self.nameTextField.layer.cornerRadius = 10
        self.addressTextField.layer.cornerRadius = 10
        self.phoneTextField.layer.cornerRadius = 10
        self.emailTextFIeld.layer.cornerRadius = 10
        
        if AppManager.shared.resumeData.contactInfoData != nil {
            
            nameTextField.text = contactInfo?.name
            addressTextField.text = contactInfo?.address
            phoneTextField.text = contactInfo?.phoneNumber
            emailTextFIeld.text = contactInfo?.email
        }
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if nameTextField.text?.isEmpty == false && addressTextField.text?.isEmpty == false && phoneTextField.text?.isEmpty == false && emailTextFIeld.text?.isEmpty == false {
            
            let contactInfo = ContactInfoModel(name: nameTextField.text ?? "", address: addressTextField.text ?? "", email: emailTextFIeld.text ?? "", phoneNumber: phoneTextField.text ?? "")
            AppManager.shared.resumeData.contactInfoData = contactInfo
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        else {
            
            nameTextField.showError(textField: nameTextField)
            addressTextField.showError(textField: addressTextField)
            phoneTextField.showError(textField: phoneTextField)
            emailTextFIeld.showError(textField: emailTextFIeld)
        }
    }
}
