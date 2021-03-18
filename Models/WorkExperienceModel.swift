//
//  WorkExperienceModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import UIKit


class WorkExperienceModel {
    
    var title: String?
    var experience: Float?
    var workedPlacesDetails = [WorkPlaceDetailsModel]()
    var tableDataArray = [WorkPlaceDetailsModel]()
    
    init(title: String, experience: Float) {
        
        self.title = title
        self.experience = experience
    }
    
    init() {
        
    }
}

class WorkPlaceDetailsModel {
    
    var position: String?
    var subtitle: String?
    var date: String?
    var accomplishment: [String.SubSequence]?
    
    init(position: String, subtitle: String, date: String, accomplishment: [String.SubSequence]){
        
        self.position = position
        self.subtitle = subtitle
        self.date = date
        self.accomplishment = accomplishment
    }
    init(){
        
    }
}
