//
//  PreviewViewController.swift
//  Resume Builder
//
//  Created by Usama on 16/03/2021.
//

import UIKit
import PDFKit

class PreviewViewController: UIViewController {

//MARK:- Class Properties
    var documentURLString: String?
//MARK:- IBOutlets
    @IBOutlet weak var previewView: PDFView!
    
//MARK:- Base Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK:- Class Methods
extension PreviewViewController {
    
    fileprivate func initialSetup(){
        
        self.navigationItem.title = "Preview"
        previewView.autoScales = true
        
        if let documentURL = URL(string: documentURLString ?? ""){
            
            let document = PDFDocument(url: documentURL)
            previewView.document = document
        }
    }
}

//MARK:- IBActions
extension PreviewViewController {
    
    
}
