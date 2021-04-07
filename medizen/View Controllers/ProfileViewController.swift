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
/// Update View Profile fields after user updates their profile
/// clean up code, add comments

import UIKit
import Lottie



class ProfileViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet var userName : UILabel!
    @IBOutlet var userEmail : UILabel!
    @IBOutlet var userAge : UILabel!
    
    @IBOutlet var currentStreak : UILabel!
    @IBOutlet var currentStreakBadge : UIImageView!
    @IBOutlet var oneDayStreakBadge : UIImageView!
    @IBOutlet var threeDayStreakBadge : UIImageView!
    @IBOutlet var tenDayStreakBadge : UIImageView!
    @IBOutlet var fifteenDayStreakBadge : UIImageView!
    @IBOutlet var thirtyDayStreakBadge : UIImageView!
    @IBOutlet var ninetyDayStreakBadge : UIImageView!
    @IBOutlet var hundredEightyDayStreakBadge : UIImageView!
    @IBOutlet var threeSixFiveDayStreakBadge : UIImageView!
    
    @IBAction func returnToProfileViewController (Sender: UIStoryboardSegue){
        
    }
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    var badges : [UIImageView : Int] = [:]

 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //update alpha value of images based on which badges user has achieved
        badges[oneDayStreakBadge] = mainDelegate.streaks[0].days
        badges[threeDayStreakBadge] = mainDelegate.streaks[1].days
        badges[tenDayStreakBadge] = mainDelegate.streaks[2].days
        badges[fifteenDayStreakBadge] = mainDelegate.streaks[3].days
        badges[thirtyDayStreakBadge] = mainDelegate.streaks[4].days
        badges[ninetyDayStreakBadge] = mainDelegate.streaks[5].days
        badges[hundredEightyDayStreakBadge] = mainDelegate.streaks[6].days
        badges[threeSixFiveDayStreakBadge] = mainDelegate.streaks[7].days
                
        for(key, value) in badges {
            if value > mainDelegate.user.streak! {
                key.alpha = 0.4
            } else {
                key.alpha = 1
            }
        }
        
        mainDelegate.getCurrentStreak(days: mainDelegate.user.streak!)
        
        userName.text = mainDelegate.user.name!
        userEmail.text = mainDelegate.user.email!
        userAge.text = String(mainDelegate.user.age!)
        
        
        if mainDelegate.usersCurrentStreak.days == nil {
            currentStreak.text = "0 Days"
            animateEmpty()
        } else {
            currentStreak.text = "\(String(mainDelegate.usersCurrentStreak.days!)) Days"
            let badgeImage : UIImage = UIImage(named:mainDelegate.usersCurrentStreak.imageUrl!)!
            
            currentStreakBadge = UIImageView(image: badgeImage)
            currentStreakBadge.frame = CGRect(x: 235, y: 315, width: 140, height: 175)
            view.addSubview(currentStreakBadge)
            animateConfetti()
            
        }
        
        
    }
    
    //ref: https://www.youtube.com/watch?v=1nzYysilBNo&ab_channel=DesignCode
    func animateConfetti(){
        let animationView = AnimationView(name:"confetti")
        animationView.frame = CGRect(x: 175, y: 250, width: 250, height: 300)
        //animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .repeat(3)
    }
    
    func animateEmpty(){
        let animationView = AnimationView(name:"sad")
        animationView.frame = CGRect(x: 215, y: 250, width: 180, height: 250)
        //animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .loop
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
