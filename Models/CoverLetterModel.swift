//
//  CoverLetterModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import UIKit

class CoverLetterModel {
    
    var includeSwitch: UInt?
    var date: String?
    var addressedTo: String?
    var body: String?
    
    init(includeSwitch: UInt, date: String, addressedTo: String, body: String) {
        self.includeSwitch = includeSwitch
        self.date = date
        self.addressedTo = addressedTo
        self.body = body
    }
    
    init(){
        
    }
}
