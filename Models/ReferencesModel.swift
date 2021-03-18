//
//  ReferencesModel.swift
//  Resume Builder
//
//  Created by Usama on 11/03/2021.
//

import Foundation

class ReferencesModel{
    
    var title: String?
    var content: String?
    var bulletPointSwitch: UInt?
    
    init(title: String, content: String, bulletPointSwitch: UInt){
        self.title = title
        self.content = content
        self.bulletPointSwitch = bulletPointSwitch
    }
    
    init(){
        
    }
}
