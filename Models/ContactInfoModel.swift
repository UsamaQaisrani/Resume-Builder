//
//  ContactInfoModel.swift
//  Resume Builder
//
//  Created by Usama on 10/03/2021.
//

import Foundation

class ContactInfoModel {
    var name: String?
    var address: String?
    var email: String?
    var phoneNumber: String?
    
    init(name: String, address: String, email: String, phoneNumber: String){
        self.name = name
        self.address = address
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    init(){
        
    }
}
