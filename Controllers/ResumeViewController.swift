//
//  ResumeViewController.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import UIKit
import PDFKit
import CoreGraphics

class ResumeViewController: UIViewController {

//MARK:- Class Properties
    var data: Data?
    let contactInfo = AppManager.shared.resumeData.contactInfoData
    var pdfData: Data?
    
//MARK:- IBOutlets
    @IBOutlet weak var resumeView: PDFView!
    
//MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension ResumeViewController {
    
    fileprivate func initialSetup(){
        
        self.navigationItem.title = "Preview"
        self.resumeView.autoScales = true
    
        let dataViewModel = DataViewModel()
        dataViewModel.createResume { (document) in
            self.pdfData = document
            self.resumeView.document = PDFDocument(data: document)
        }
        
//        let data = ResumeCreator.shared.prepareData()
//        resumeView.document = PDFDocument(data: data)

        let shareButton = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonPressed))
        
        self.navigationItem.rightBarButtonItem = shareButton
        
    }
    
    @objc func shareButtonPressed(sender: AnyObject){
        
        let dataViewModel = DataViewModel()
        dataViewModel.saveData(data: pdfData ?? Data(),fileName: contactInfo?.name ?? "Usama")
    }
}

//MARK:- IBActions
extension ResumeViewController {
    
    
    
}

