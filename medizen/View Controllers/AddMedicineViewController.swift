//
//  AddUserViewController.swift
//  medizen
//
//  Created by Vinayak Pavate on 2021-04-01.
//

import UIKit

class AddMedicineViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDosage: UITextField!
    @IBOutlet weak var controlMeasure: UISegmentedControl!
    @IBOutlet weak var textFrequency: UITextField!
    @IBOutlet weak var textQuantity: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    
    /*
    var selectedDose = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let med : Medication = Medication.init()
        updateDosage()
        let myIntDose = Int(textDosage.text!)!
        let myIntQuant = Int(textQuantity.text!)!
        med.initWithData(theRow: 0, theMedName: textName.text!, theFrequency: textFrequency.text!, theDosage: myIntDose, theDoseMeasure: selectedDose, theQuantity: myIntQuant, theDescrip: textDescription.text!)
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
      //  _ = mainDelegate.insertIntoMedicationDataBase(med: med)
    }
    
    func updateDosage(){
        let dose = controlMeasure.selectedSegmentIndex
        if dose == 0
        {
           selectedDose = "mg"
        }
        else if dose == 1
        {
            selectedDose = "mcg"
        }
        else if dose == 2
        {
            selectedDose = "ml"
        }
        else if dose == 3
        {
            selectedDose = "tablet(s)"
            
        }
    }
    */
}

