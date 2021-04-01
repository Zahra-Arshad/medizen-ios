//
//  AddUserViewController.swift
//  medizen
//
//  Created by Vinayak Pavate on 2021-04-01.
//

import UIKit

class AddUserViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textAge: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //This is the fuction when a user clicks on the save button
    @IBAction func btnSave(_ sender: Any) {
        let user : User = User.init()
        let myInt2 = Int(textAge.text!)!
        user.initWithData(theRow: 0,theName: textName.text!,theEmail: textEmail.text!,theAge: myInt2 ,thePassword: textPassword.text!)
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        _ = mainDelegate.insertIntoUserDataBase(user: user)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
}

