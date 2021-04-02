//
//  Milestone.swift
//  medizen
//
//  Created by  on 4/1/21.
//

import UIKit

class Milestone: NSObject {
    var id: Int?
    var name: String?
    var email: String?
    var age: Int?
    var password: String?
    
    func initWithData( theRow i: Int, theName n: String, theEmail e: String, theAge a: Int, thePassword p: String){
        id = i
        name = n
        email = e
        age = a
        password = p
    }}
