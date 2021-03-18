//
//  ObjectiveModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation
import UIKit

class ObjectiveModel {
    
    var content: String?
    var title: String?
    var bulletPointSwitch: UInt?
    
    init(content: String, title: String, bulletPointSwitch: UInt){
        self.content = content
        self.title = title
        self.bulletPointSwitch = bulletPointSwitch
    }
    
    init(){
        
    }
}
