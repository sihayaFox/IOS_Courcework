//
//  fooditem.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-22.
//

import Foundation
import UIKit

class fooditem {
    var Name : String
    var discription : String
    var price : Float
    var discount : Int
    var id : String
    var documentId : String
    var category : String
    var active : Bool
   
    
    init(Name : String,discription : String,price : Float,discount:Int,id:String,documentId:String,category:String,active:Bool) {
        
        self.Name = Name
        self.discription = discription
        self.price = price
        self.discount = discount
        self.id = id
        self.documentId = documentId
        self.category = category
        self.active = active
        
        
    }
}
