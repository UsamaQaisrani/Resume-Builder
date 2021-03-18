//
//  templateCell.swift
//  Resume Builder
//
//  Created by Usama on 16/03/2021.
//

import Foundation
import UIKit
import PDFKit

class TemplateCell : UICollectionViewCell {

//MARK:- Class Properties
    let pdfView = PDFView()
    var data: Data?
//MARK:- IBOutlets
    
    @IBOutlet weak var templateView: PDFView!
    @IBOutlet weak var userNameLabel: UILabel!
    
//MARK:- Class Methods
    
    func configureCell(){
        
        templateView.backgroundColor = .systemOrange
        
        let dataViewModel = DataViewModel()
        let url = Services.shared.getDocumentsDirectory()
        let docUrl : String = "\(url.absoluteURL)Usama.pdf"
        let pdfUrl = URL(string: docUrl)
        let document = PDFDocument(url: pdfUrl!)
        self.templateView.document = document
        self.templateView.autoScales = true
        self.templateView.layer.borderWidth = 0.5
        self.templateView.layer.borderColor = CGColor(red: 255.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
}

//MARK:- IBActions

