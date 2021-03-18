//
//  ViewController.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import UIKit

class MainTableViewController: UITableViewController {

    //MARK:- Class Properties

    //MARK:- IBOutlets
    @IBOutlet var mainTableView: UITableView!
    
    //MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
}

//MARK:- Class Methods
extension MainTableViewController {
    
    func initialSetup(){
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        self.navigationItem.title = "Resume"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 128.0/255.0, green: 0.0/255.0, blue: 34.0/255.0, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        
        if cell?.tag == 0{
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "contactInfoViewController") as! ContactInfoViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 1{
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "coverLetterViewController") as! CoverLetterViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 2 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "objectiveViewController") as! ObjectiveViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 3 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "qualificationViewController") as! QualificationViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 4 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "workExperienceViewController") as! WorkExperienceViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 5 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "educationViewController") as! EducationViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 6 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "referencesViewController") as! ReferencesViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 7 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "resumeViewController") as! ResumeViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        
        else if cell?.tag == 8 {
            
            let storyboard = self.storyboard?.instantiateViewController(identifier: "templateViewController") as! TemplateViewController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
}

//MARK:- IBActions
extension MainTableViewController {
    
}
