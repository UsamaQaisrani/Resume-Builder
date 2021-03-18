//
//  EducationModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation

class EducationModel {
    
    var title: String?
    var educationPlaceDetails = [EducationPlaceDetailsModel]()
    
    init(title: String){
        
        self.title = title
    }
    
    init(){
        
        
    }

    
}

class EducationPlaceDetailsModel {
    
    var degree: String?
    var school: String?
    var date: String?
    var accomplishment: [String.SubSequence]?
    
    init(degree: String, school: String, date: String, accomplishment: [String.SubSequence]){
        self.degree = degree
        self.school = school
        self.date = date
        self.accomplishment = accomplishment
    }
    init(){
        
    }
}
