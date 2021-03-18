//
//  QualificationsModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import UIKit

class QualificationsModel {
    
    var title: String?
    var content: [String.SubSequence]?
    var bulletPointSwitch: UInt?
    
    init(title: String, content: [String.SubSequence], bulletPointSwitch: UInt){
        self.title = title
        self.content = content
        self.bulletPointSwitch = bulletPointSwitch
    }
    
    init(){
        
    }
    
}
