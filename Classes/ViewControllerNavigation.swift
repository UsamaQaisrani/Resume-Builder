//
//  ViewControllerNavigation.swift
//  Resume Builder
//
//  Created by Usama on 18/03/2021.
//

import Foundation
import UIKit

class Navigate {
    
    func navigate(viewControllerName: String){
    
        if  let storyboard = self.storyboard?.instantiateViewController(identifier: "\(viewControllerName)"){
            
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
}
