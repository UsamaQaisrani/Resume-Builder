//
//  TemplateCollectionViewCell.swift
//  Resume Builder
//
//  Created by Usama on 16/03/2021.
//

import Foundation
import UIKit
import PDFKit

class TemplateCollectionViewCell : UICollectionViewCell{
    
//MARK:- Class Properties
    
    var pdfView: PDFView?


//MARK:- IBOutlets
    
    @IBOutlet weak var templateView: PDFView!
    
//MARK:- Class Methods
    
    func configureCell(documentList: String){
        
        templateView.autoScales = true
        
        let dataViewModel = DataViewModel()
        dataViewModel.getdocumentPath { (url) in
            if let docURL = URL(string: documentList){
                
            let document = PDFDocument(url: docURL)
                self.templateView.document = document
            }
        }
    }
}
