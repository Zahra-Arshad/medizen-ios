//
//  EditProfileViewController.swift
//  medizen
//
//  Created by Martha Czerwik on 4/1/21.
//

/// <#DESCRIPTION#>
/// Code behind the 'Edit Profile' page, pulls from the User table in the database/User object stored once the user logs in to prepopulate the editable fields

/// <#TODO#>
/// clean up code, add comments

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userName : UITextField!
    @IBOutlet var userEmail : UITextField!
    @IBOutlet var userAge : UITextField!
    @IBOutlet var userPassword : UITextField!
    @IBOutlet var userPasswordConfirm : UITextField!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func updateProfile(sender : UIButton){
        if checkPasswordsMatch() == false {
            let alert = UIAlertController(title: "Error", message: "Passwords must match!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
            
        }
        
        if checkIfFieldsEmpty() == true {
            let alert = UIAlertController(title: "Error", message: "All fields must be filled in!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true)
            
        }
        
        if (checkPasswordsMatch() == true && checkIfFieldsEmpty() == false){
                        
            let updatedName = userName.text
            let updatedEmail = userEmail.text
            let updatedAge = Int(userAge.text!)
                    
            print("Values to pass to update method: name= \(updatedName), email= \(updatedEmail), age= \(updatedAge)")
            let returnCode = mainDelegate.updateUser(userId: mainDelegate.user.id!, userName: updatedName!, userEmail: updatedEmail!, userAge: updatedAge!)

            if returnCode == false {
                let alertController = UIAlertController(title: "Error", message: "Unable to update profile. Please try again later.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController, animated: true)
            }
            
                performSegue(withIdentifier: "UpdateProfileSegue", sender: self)
            
        }
    
    }
    
    
    override func viewDidLoad() {
        self.hideKeyboard()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName.text = mainDelegate.user.name
        userEmail.text = mainDelegate.user.email
        userAge.text = String(mainDelegate.user.age!)
        userPassword.text = mainDelegate.user.password
        userPasswordConfirm.text = mainDelegate.user.password
    }
    
    func checkPasswordsMatch() -> Bool{
        
        var passwordsMatch = true
        
        if (userPassword.text == userPasswordConfirm.text){
            passwordsMatch = true
        } else {
            passwordsMatch = false
        }
        return passwordsMatch
        
    }
    
    func checkIfFieldsEmpty() -> Bool {
        var emptyFieldsExist = false
        
        if (userName.text == "" || userEmail.text == "" || userAge.text == "" || userPassword.text == "" || userPasswordConfirm.text == "") {
            emptyFieldsExist = true
        } else {
            emptyFieldsExist = false
        }
        return emptyFieldsExist
    }
    
    
    @IBAction func togglePasswordVisibility(sender: UIButton) {
        userPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func toggleConfimPasswordVisibility(sender: UIButton){
        userPasswordConfirm.isSecureTextEntry.toggle()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    

    @IBAction func hideKeyboard(){
        self.view.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    func endEditingRecognizer() ->UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action:#selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
