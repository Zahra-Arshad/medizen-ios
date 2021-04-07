//
//  User.swift
//  CapstoneProject
//
//  Created by Vinayak Pavate on 04/01/21.
//

import Foundation

class User: NSObject {
    var id: Int?
    var name: String?
    var email: String?
    var age: Int?
    var password: String?
    var streak: Int?
    
    func initWithData( theRow i: Int, theName n: String, theEmail e: String, theAge a: Int, thePassword p: String, theStreak s: Int){
        id = i
        name = n
        email = e
        age = a
        password = p
        streak = s
    }

 

} 
