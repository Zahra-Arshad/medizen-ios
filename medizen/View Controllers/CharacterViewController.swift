//
//  CharacterViewController.swift
//  SwiftTables1
//
//  Created by  on 3/18/21.
//

import UIKit

class CharacterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listData: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        listData = ["Woof", "Pupper", "Chubz", "Steve", "Doge", "Tubz"]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell()
        
        let rowNum = indexPath.row
        tableCell.textLabel?.text = listData[rowNum]
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let more = UIContextualAction(style: .destructive, title: "More") { (action, view, handler) in
            print("More Button Tapped")
        }
        
        more.backgroundColor = .lightGray
        
        let favourite = UIContextualAction(style: .destructive, title: "Favourite") { (action, view, handler) in
            print("Favourite Button Tapped")
        }
        
        favourite.backgroundColor = .orange
        
        let share = UIContextualAction(style: .destructive, title: "Share") { (action, view, handler) in
            print("Share Button Tapped")
        }
        share.backgroundColor = .blue
        
        let configuration = UISwipeActionsConfiguration(actions: [share, favourite, more])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title: "Modify", handler: {
            ac, view, success in
            print("modify button tapped")
            success(true)
        })
        modifyAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }

}
