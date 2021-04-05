//
//  ContactCell.swift
//  medizen
//
//  Created by  on 4/1/21.
//

import UIKit
import Contacts

class ContactCell: UITableViewCell {
  @IBOutlet private weak var contactNameLabel: UILabel!
  @IBOutlet private weak var contactEmailLabel: UILabel!
  @IBOutlet private weak var contactImageView: UIImageView! {
    didSet {
      contactImageView.layer.masksToBounds = true
      contactImageView.layer.cornerRadius = 22.0
    }
  }
  
  var contact : Contact? {
    didSet {
      configureCell()
    }
  }
  
  private func configureCell() {
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    guard let contact = contact,
      let name = formatter.string(from: contact.contactValue) else { return }
    contactNameLabel.text = name
    contactEmailLabel.text = contact.workEmail
    contactImageView.image = contact.profilePicture ?? UIImage(named: "PlaceholderProfilePic")
  }
}
