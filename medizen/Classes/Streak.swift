//
//  Streak.swift
//  medizen
//
//  Created by Martha Czerwik on 4/1/21.
//

/// <#DESCRIPTION#>
/// Stores information about streak objects the user can acquire, stored in the Streak table in the database
/// Each streak object holds a value for it's unique ID, the number of days associated with reaching that streak, and the image for the badge associated with that streak, which will be saved in the Assets folder

/// <#TODO#>
/// See if any other fields are necessary for this table/object


import UIKit

class Streak: NSObject {

        var id: Int?
        var days: Int?
        var imageUrl: String?
        
        func initWithData( streakId i: Int, streakDays d: Int, streakImageUrl url: String){
            id = i
            days = d
            imageUrl = url
        }

}
