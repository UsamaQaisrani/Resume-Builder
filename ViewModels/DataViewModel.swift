//
//  DataViewModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation


class DataViewModel {
    
    //MARK:- Class Properties
    var contactInfo: ContactInfoModel?
    
    //MARK:- Initializers
    init(contactInfo: ContactInfoModel){
        self.contactInfo = contactInfo
    }
    init(){
        
    }
    
}
//MARK:- Class Methods
extension DataViewModel {
    
    func createResume(completion: @escaping (Data)->Void){
        
       let data =  PDFCreator.shared.createResume()
        completion(data)
    }
    
    func saveData(data: Data, fileName: String){
        
        Services.shared.saveData(data: data ?? Data(), fileName: fileName)
    }
    
    func getData(completion: @escaping ([String])->Void) {
        
        Services.shared.getAllFiles { (filesList) in
            AppManager.shared.filesList = filesList
            completion(filesList)
        }
    }
    
    func getdocumentPath(completion: @escaping (URL)->Void){
        
        let url = Services.shared.getDocumentsDirectory()
        completion(url)
    }
}
