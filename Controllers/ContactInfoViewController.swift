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
            
            nameTextField.text = AppManager.shared.resumeData.contactInfoData?.name
            addressTextField.text = AppManager.shared.resumeData.contactInfoData?.address
            phoneTextField.text = AppManager.shared.resumeData.contactInfoData?.phoneNumber
            emailTextFIeld.text = AppManager.shared.resumeData.contactInfoData?.email
            
        }
        
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if nameTextField.text != "" && addressTextField.text != "" && phoneTextField.text != "" && emailTextFIeld.text != "" {
            
            let contactInfo = ContactInfoModel(name: nameTextField.text ?? "", address: addressTextField.text ?? "", email: emailTextFIeld.text ?? "", phoneNumber: phoneTextField.text ?? "")
            AppManager.shared.resumeData.contactInfoData = contactInfo
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        else {
            
            if nameTextField.text == "" {
                
                self.nameTextField.layer.borderWidth = 0.5
                self.nameTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
            if addressTextField.text == ""{
                
                self.addressTextField.layer.borderWidth = 0.5
                self.addressTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
            if phoneTextField.text == ""{
                
                self.phoneTextField.layer.borderWidth = 0.5
                self.phoneTextField.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
            if emailTextFIeld.text == "" {
                
                self.emailTextFIeld.layer.borderWidth = 0.5
                self.emailTextFIeld.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
                
            }
        }
    }
    
}

//MARK:- IBActions
extension ContactInfoViewController {
    
    
    
}