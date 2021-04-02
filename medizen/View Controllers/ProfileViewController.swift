//
//  ProfileViewController.swift
//  medizen
//
//  Created by Martha Czerwik on 4/1/21.
//

/// <#DESCRIPTION#>
/// Code behind the 'View Profile' page, pulls from the User table in the database/User object stored once the user logs in
/// Displays user's information along with streak information - what the user's current streak is, as well as an array of streaks
/// that the user has achieve/has yet to achieve

/// <#TODO#>
/// Pull values from User object
/// Get array of streaks and find which ones should be "greyed" out (not acheived yet)
/// Add animation for current badge

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var userName : UILabel!
    @IBOutlet var userEmail : UILabel!
    @IBOutlet var userAge : UILabel!
    @IBOutlet var currentStreak : UILabel!
    @IBOutlet var currentStreakBadge : UIImageView!
    

    
    @IBAction func returnToProfileViewController (Sender: UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
