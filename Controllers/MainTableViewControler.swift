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
    
    func navigate(viewControllerName: String){
        
        let storyboard = self.storyboard?.instantiateViewController(identifier: viewControllerName) ?? UIViewController()
        navigationController?.pushViewController(storyboard, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        
        if cell?.tag == 0{

            navigate(viewControllerName: "contactInfoViewController")
        }
        
        else if cell?.tag == 1{

            navigate(viewControllerName: "coverLetterViewController")
        }
        
        else if cell?.tag == 2 {

            navigate(viewControllerName: "objectiveViewController")
        }
        
        else if cell?.tag == 3 {
            
            navigate(viewControllerName: "qualificationViewController")
        }
        
        else if cell?.tag == 4 {
            
            navigate(viewControllerName: "workExperienceViewController")
        }
        
        else if cell?.tag == 5 {
            
            navigate(viewControllerName: "educationViewController")
        }
        
        else if cell?.tag == 6 {
            
            navigate(viewControllerName: "referencesViewController")
        }
        
        else if cell?.tag == 7 {
            
            navigate(viewControllerName: "resumeViewController")
        }
        
        else if cell?.tag == 8 {
            
            navigate(viewControllerName: "templateViewController")
        }
    }
}
