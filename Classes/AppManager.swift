//
//  AppManager.swift
//  Resume Builder
//
//  Created by Usama on 12/03/2021.
//

import Foundation

class AppManager{
    
    //MARK:- Class Properties
    var resumeData = ResumeBaseModel()
    
    static let shared = AppManager()
    
    var filesList: [String]?
    
    var tableDataArray = [WorkPlaceDetailsModel]()
    
}
