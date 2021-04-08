//
//  AppDelegate.swift
//  medizen
//
//  Created by Zahra Arshad on 2021-03-26.
//  Modified by Martha Czerwik on April 06 2021


import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName : String? = "Medizen.db"
    var databasePath : String?
    
    //var users : [User] = []

    var user : User = User.init()
    var streaks : [Streak] = []
    var usersCurrentStreak : Streak = Streak.init()
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentDir = documentPaths[0]
        databasePath = documentDir.appending("/" + databaseName!)
        print("Database path: \(databasePath)")
        
        checkAndCreateDatabase()
        getStreakData()
        
    
        
        
        
        return true
    }
    
    func checkAndCreateDatabase(){
        var success = false
        
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success {
            return
        }

        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)

        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    
    //THISMETHOD TO BE CALLED IN LOGIN CONTROLLER - PASS IN VALUES FOR EMAIL AND PASSWORD
    func readUserData(){
    //UNCOMMENT THIS WHEN LOGIN CONTROLLER DONE - REPLACE METHOD SIGNATURE
    //func readDataFromDatabase(email : String, password : String){
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            
            let queryStatementString : String = "select * from users where email = 'jdoe@mail.com' and password = 'password4321'"
            
            //UNCOMMENT THIS WHEN LOGIN CONTROLLER DONE AND REMOVE ABOVE QUERYSTATEMENT ^
            //let queryStatementString : String = "select * from users where email = '\(email)' and password = '\(password)'"

            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let cemail = sqlite3_column_text(queryStatement, 2)
                    let age = Int(sqlite3_column_int(queryStatement, 3))
                    let cpassword = sqlite3_column_text(queryStatement, 4)
                    let streak = Int(sqlite3_column_int(queryStatement, 5))
                    
                    let name = String(cString: cname!)
                    let email = String(cString: cemail!)
                    let password = String(cString: cpassword!)
                    
                    user.initWithData(theRow: id,
                                        theName: name,
                                        theEmail: email,
                                        theAge: age,
                                        thePassword: password,
                                        theStreak: streak)
                    
                    print("Query result")
                    print("\(id) | \(name) | \(email) | \(age) | \(password) | \(streak)")
                                        
                }
                
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open database")
        }
    }// end of readUserData
    
    /**
        Created by: Martha Czerwik
        Description: Pulls all rows from Streak table
     */
    func getStreakData(){
        var db : OpaquePointer? = nil

        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            
            let queryStatementString : String = "select * from streaks"

            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let days: Int = Int (sqlite3_column_int(queryStatement, 1))
                    let cimageUrl = sqlite3_column_text(queryStatement, 2)
                    
                    let imageUrl = String(cString: cimageUrl!)
                   
                    let streak : Streak = Streak.init()
                    streak.initWithData(streakId: id,
                                        streakDays: days,
                                        streakImageUrl: imageUrl)
                    streaks.append(streak)
                    
                    print("Query result for streak: ")
                    print("\(id) | \(days) | \(imageUrl)")
                                        
                }
                
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open database")
        }
    } // end of getStreakData
    
    /**
        Created by: Martha Czerwik
        Description: Pulls the user's most recently achieved badge from Streaks table
     */
    func getCurrentStreak(days: Int){
        var db : OpaquePointer? = nil

        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to database at \(self.databasePath)")
            
            var queryStatement : OpaquePointer? = nil
            
            let queryStatementString : String = "select * from streaks where days <= \(days) order by days desc limit 1"

            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let days: Int = Int (sqlite3_column_int(queryStatement, 1))
                    let cimageUrl = sqlite3_column_text(queryStatement, 2)
                    
                    let imageUrl = String(cString: cimageUrl!)
                   
                    usersCurrentStreak.initWithData(streakId: id,
                                        streakDays: days,
                                        streakImageUrl: imageUrl)
                    
                    
                                    
                    print("Query result for current streak: ")
                    print("\(id) | \(days) | \(imageUrl)")
                                        
                }
                
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open database")
        }
    } // end of getCurrentStreak
    
    
    
    
    /**
        Created by: Martha Czerwik
        Description: Update User table when user edits their profile
     */
    func updateUser(userId : Int, userName : String, userEmail : String, userAge : Int) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            print("method params = name: \(userName), email: \(userEmail), age: \(userAge)")
            
            var updateStatement : OpaquePointer? = nil
            let updateStatementString : String = "update users set name = '\(userName)', email = '\(userEmail)', age = \(userAge) where id = \(userId)"
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                
                user.name = userName
                user.email = userEmail
                user.age = userAge
                
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Successfully updated user \(userId)")
                    print("Query result")
                    print("\(userName) | \(userEmail) | \(userAge)")
                } else {
                    print("Could not update user")
                    returnCode = false
                }
                sqlite3_finalize(updateStatement)
            } else {
                print("update statement could not be prepared")
                returnCode = false
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open db")
            returnCode = false
        }
        
        return returnCode
    }
    
    
    
    
    
    
/*
    var userdatabaseName : String? = "userDatabase.db"
    var userdatabasePath : String?
    
    var medicinedatabaseName : String? = "medicineDatabase.db"
    var medicinedatabasePath : String?
    
    
    var users : [User] = []
    var user : User = User.init()
    
    var medicines : [Medication] = []
    var med : Medication = Medication.init()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        medicinedatabasePath = documentsDir.appending("/"+medicinedatabaseName!)
        // Override point for customization after application launch.
      //  checkAndCreateUserDatabase()
      //  readDataFromUserDatabase()
      checkAndCreateMedicationDatabase()
        readDataFromMedicationDatabase()
        return true
    }
    
    /////////USER DATABASE STUFF
    //////
    /////////
    /////////////////////////////
    //////////////////////
    func readDataFromUserDatabase(){
        users.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.userdatabasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to db at \(String(describing: self.userdatabasePath))")
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "select * from entries"
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let cemail = sqlite3_column_text(queryStatement, 2)
                    let cage = Int(sqlite3_column_int(queryStatement, 3))
                    let cpassword = sqlite3_column_text(queryStatement, 4)
                    
                    let name = String(cString: cname!)
                    let email = String(cString: cemail!)
                    let age = Int(cage)
                    let password = String(cString: cpassword!)
                    
                    let user : User = User.init()
                    user.initWithData(theRow: id,
                                        theName: name,
                                        theEmail: email,
                                        theAge: age,
                                        thePassword: password)
                    users.append(user)
                    
                    print("Query result")
                    print("\(name) | \(email) | \(age) | \(password)")
                    
                }
                sqlite3_finalize(queryStatement)
            } else {
                print("select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open db")
        }
    }
    func checkAndCreateUserDatabase(){
        var success = false
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: userdatabasePath!)
        if success {
            return
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/"+userdatabaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: userdatabasePath!)
        return
    }
    func insertIntoUserDataBase(user : User) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.userdatabasePath, &db) == SQLITE_OK {
            var insertStatement : OpaquePointer? = nil
            let insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?)"
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                let nameStr = user.name! as NSString
                let emailStr = user.email! as NSString
                let ageInt = user.age! as NSInteger
                let passwordString = user.password! as NSString

                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, emailStr.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 3, Int32(ageInt))
                sqlite3_bind_text(insertStatement, 4, passwordString.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowId = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowId)")
                } else {
                    print("Could not insert row")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            } else {
                print("Insert statement could not be prepared")
                returnCode = false
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open db")
            returnCode = false
        }
        
        return returnCode
    }
    ///////// MEDICINE DATABASE STUFF
    //////
    /////////
    /////////////////////////////
    //////////////////////
    func readDataFromMedicationDatabase(){
        medicines.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.medicinedatabasePath, &db) == SQLITE_OK {
            
            print("Successfully opened connection to db at \(String(describing: self.medicinedatabasePath))")
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "select * from entries"
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cmedname = sqlite3_column_text(queryStatement, 1)
                    let cdosage: Int = Int(sqlite3_column_int(queryStatement, 2))
                    let cdoseMea = sqlite3_column_text(queryStatement, 3)
                    let cfrecq = sqlite3_column_text(queryStatement, 4)
                    let cquant : Int = Int(sqlite3_column_int(queryStatement, 5))
                    let cdescrip = sqlite3_column_text(queryStatement, 6)
                    
                    let name = String(cString: cmedname!)
                    let dosage = Int(cdosage)
                    let doseMeasure = String(cString : cdoseMea!)
                    let frequency = String(cString: cfrecq!)
                    let quantity = Int(cquant)
                    let descrip = String(cString: cdescrip!)
                    
                    let med : Medication = Medication.init()
                    med.initWithData(theRow: id,
                                     theMedName: name,
                                     theFrequency: frequency,
                                        theDosage: dosage,
                                        theDoseMeasure: doseMeasure,
                                        theQuantity: quantity,
                                        theDescrip: descrip)
                    medicines.append(med)
                    
                    print("Query result")
                    print("\(name) | \(dosage) | \(doseMeasure) | \(frequency) | \(quantity) | \(descrip) ")
                    
                }
                sqlite3_finalize(queryStatement)
            } else {
                print("select statement could not be prepared")
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open db")
        }
    }
    func checkAndCreateMedicationDatabase(){
        var success2 = false
        let fileManager = FileManager.default
        success2 = fileManager.fileExists(atPath: medicinedatabasePath!)
        if success2 {
            return
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/"+medicinedatabaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: medicinedatabasePath!)
        return
    }
    func insertIntoMedicationDataBase(med : Medication) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.medicinedatabasePath, &db) == SQLITE_OK {
            var insertStatement : OpaquePointer? = nil
            let insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?, ?, ?)"
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                let nameStr = med.medName! as NSString
                let dosageInt = med.dosage! as NSInteger
                let dosMeaStr = med.doseMeasure! as NSString
                let frequStr = med.frequency! as NSString
                let quantInt = med.quantity! as NSInteger
                let descripStr = med.descrip! as NSString

                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 2, Int32(dosageInt))
                sqlite3_bind_text(insertStatement, 3, dosMeaStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, frequStr.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 5, Int32(quantInt))
                sqlite3_bind_text(insertStatement, 6, descripStr.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowId = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row \(rowId)")
                } else {
                    print("Could not insert row")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            } else {
                print("Insert statement could not be prepared")
                returnCode = false
            }
            
            sqlite3_close(db)
            
        } else {
            print("Unable to open db")
            returnCode = false
        }
        
        return returnCode
    }
*/

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

