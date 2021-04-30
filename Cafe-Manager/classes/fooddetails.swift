//
//  fooddetails.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-22.
//

import Foundation
import UIKit

class fooddetails {
    var category : String
    var food : [fooditem]
   
    
    init(category : String,food : [fooditem] ) {
        
        
        self.category = category
        self.food = food
        
    }
}
