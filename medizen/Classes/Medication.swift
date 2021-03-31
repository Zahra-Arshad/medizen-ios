//
//  Medication.swift
//  medizen
//
//  Created by Zahra Arshad on 2021-03-31.
//
//  Class for Mecication
//

import UIKit

class Medication: NSObject {
    
    var id: Int?
    // medication name
    var medName: String?
    // medication dosage (ex. 20)
    var dosage: Int?
    // dosage measurement (ex. mg/mcg/ml/tablets)
    var doseMeasure: String?
    // frequency (ex. Twice per day)
    var frequency: String?
    // quantity remaining (ex. 30)
    var quantity: Int?
    // med desc (ex. Blood Pressure)
    var descrip: String?
        
        func initWithData( theRow i: Int, theMedName n: String, theFrequency f: String, theDosage d: Int, theDoseMeasure dm: String, theQuantity q: Int, theDescrip des: String){
            id = i
            medName = n
            dosage = d
            doseMeasure = dm
            frequency = f
            quantity = q
            descrip = des
        }
}
