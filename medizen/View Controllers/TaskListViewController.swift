//
//  TaskListViewController.swift
//  medizen
//
//  Created by Martha Czerwik on 4/6/21.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var taskList : UITableView!
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
    //TODO: update with array of actual task objects
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        //return mainDelegate.userTasks.count
        
    }
    
    //size of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskListCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TaskCell ?? TaskCell(style: .default, reuseIdentifier: "cell")
        
        //let rowNum = indexPath.row
          
        //populate text fields with task properties
        taskListCell.medicationName.text = "Medication name here"
        taskListCell.dosage.text = "Ignore this ugly image and formatting"
        taskListCell.scheduledDosage.text = "Take at:"
        taskListCell.pillImage.image = UIImage(named: "pillImg")
        taskListCell.viewDetaislLbl.text = "View Details"
        
        taskListCell.accessoryType = .none

        return taskListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //segue to view details of medication page, call segue
        performSegue(withIdentifier: "SegueToMedDetails", sender: nil) //from identifier of segue to view medication page in storyboard
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //POPULATE ARRAY OF TASKS
        //mainDelegate.readTaskData(mainDelegate.user.id)
        
        //set background of table if needed
        //table.backgroundView = UIImageView(image: UIImage(named: "bgImg"))
        //table.backgroundView?.contentMode = .scaleToFill
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
