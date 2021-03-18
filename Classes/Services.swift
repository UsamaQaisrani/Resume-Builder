//
//  Services.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import CoreData

class Services {
    
    //MARK:- Class Properties
    static let shared = Services()
    
    //MARK:- Class Methods
    func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    func saveData(data: Data, fileName: String){
        
        let filePath = fileName.replacingOccurrences(of: " ", with: "")
        let fileName = getDocumentsDirectory().appendingPathComponent("\(filePath).pdf")
        do {
            try data.write(to: fileName, options: .atomic)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func getData(completion: @escaping (URL)->Void){
        
        let fileManager = FileManager.default
        let fileName = getDocumentsDirectory()
        
        if fileManager.fileExists(atPath: fileName.path){
            completion(URL(fileURLWithPath: fileName.path))
        }
    }
    
    func getAllFiles(completion: @escaping ([String])->Void){
        
        let fm = FileManager.default
        let path = getDocumentsDirectory()
        let stringPath = "\(path.absoluteURL)"
        var filesList = [String]()
        
        do{
            let items = try fm.contentsOfDirectory(atPath: path.path)
            for item in items{
                let pathString = "\(getDocumentsDirectory())\(item)"
                if pathString.contains(".pdf"){
                    filesList.append(pathString)
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        completion(filesList)
    }
}
