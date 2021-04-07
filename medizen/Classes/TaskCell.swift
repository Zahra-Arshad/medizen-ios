//
//  TaskCell.swift
//  medizen
//
//  Created by Martha Czerwik on 4/6/21.
//

import UIKit

class TaskCell: UITableViewCell {
    
    let taskCardView = UIView()
    let medicationName = UILabel()
    let dosage = UILabel()
    let scheduledDosage = UILabel()
    let pillImage = UIImageView()
    let viewDetaislLbl = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        //UI properties of the cell
        taskCardView.backgroundColor = #colorLiteral(red: 0.8407177925, green: 0.9149056077, blue: 0.7366474271, alpha: 1)
        taskCardView.layer.shadowColor = UIColor.gray.cgColor
        taskCardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        taskCardView.layer.shadowOpacity = 1.0
        taskCardView.layer.masksToBounds = false
        taskCardView.layer.cornerRadius = 35.0
        
        medicationName.textAlignment = .left
        medicationName.font = UIFont.boldSystemFont(ofSize: 18)
        medicationName.backgroundColor = .clear
        medicationName.textColor = .black
        
        dosage.textAlignment = .left
        dosage.font = UIFont.boldSystemFont(ofSize: 14)
        dosage.backgroundColor = .clear
        dosage.textColor = .black
        
        scheduledDosage.textAlignment = .left
        scheduledDosage.font = UIFont.boldSystemFont(ofSize: 14)
        scheduledDosage.backgroundColor = .clear
        scheduledDosage.textColor = .black
        
        viewDetaislLbl.textAlignment = .right
        viewDetaislLbl.font = UIFont.systemFont(ofSize: 14)
        viewDetaislLbl.backgroundColor = .clear
        viewDetaislLbl.textColor = .blue
                
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        //add elements to cell, layering to make sure background is behind text
        contentView.insertSubview(taskCardView, at: 0)
        contentView.insertSubview(medicationName, at: 1)
        contentView.insertSubview(dosage, at: 1)
        contentView.insertSubview(scheduledDosage, at: 1)
        contentView.insertSubview(pillImage, at: 1)
        contentView.insertSubview(viewDetaislLbl, at: 1)
        contentView.backgroundColor = .clear
    }
    
    //position elements
    override func layoutSubviews() {
        taskCardView.frame = CGRect(x: 20, y: 15, width: 373, height: 215)
        viewDetaislLbl.frame = CGRect(x: 105, y: 60, width: 200, height: 25)
        medicationName.frame = CGRect(x: 105, y: 5, width: 400, height: 25)
        dosage.frame = CGRect(x: 105, y: 25, width: 400, height: 25)
        scheduledDosage.frame = CGRect(x: 105, y: 40, width: 400, height: 25)
        pillImage.frame = CGRect(x: 5, y: 15, width: 90, height: 90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) { //executed when something should happen when selecting table cell
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
