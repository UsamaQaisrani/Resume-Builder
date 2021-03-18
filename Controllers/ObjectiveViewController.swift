//
//  ObjectiveViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit

class ObjectiveViewController: UIViewController {
    
    //MARK:- Class Properties
    
    //MARK:- IBOutlets
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var objectiveTextField: UITextField!
    @IBOutlet weak var bulletPointSwitch: UISwitch!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
    }
}
//MARK:- Class Methods
extension ObjectiveViewController{
    
    fileprivate func initialSetup(){
        
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.cornerRadius = 10
        objectiveTextField.layer.cornerRadius = 10
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonPressed))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.title = "Objective"
        
        if AppManager.shared.resumeData.objectiveData != nil {
            
            contentTextView.text = AppManager.shared.resumeData.objectiveData?.content
            objectiveTextField.text = AppManager.shared.resumeData.objectiveData?.title
            
        }
        
    }
    
    @objc func doneButtonPressed(sender: AnyObject){
        
        if contentTextView.text != "" && objectiveTextField.text != "" {
            
            let objectiveData = ObjectiveModel(content: contentTextView.text ?? "", title: objectiveTextField.text ?? "", bulletPointSwitch: bulletPointSwitch.state.rawValue)
            AppManager.shared.resumeData.objectiveData = objectiveData
            
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        else{
            
            contentTextView.showError(textView: contentTextView)
            objectiveTextField.showError(textField: objectiveTextField)
        }
    }
}
