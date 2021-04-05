//
//  ContactsViewController.swift
//  medizen
//
//  Created by  on 4/1/21.
//

import UIKit
import ContactsUI

class ContactsViewController: UITableViewController {
  var contactsList = Contact.defaultContacts()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let logo = UIImageView(image: UIImage(named: "medizen")!)
    logo.contentMode = .scaleAspectFit
    navigationItem.titleView = logo
    self.navigationController?.navigationBar.barTintColor = UIColor.gray
    self.navigationController?.navigationBar.tintColor = UIColor.black
    navigationController?.isNavigationBarHidden = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.tintColor = .black

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if
      segue.identifier == "EditContactSegue",
      // 1
      let cell = sender as? ContactCell,
      let indexPath = tableView.indexPath(for: cell),
      let editViewController = segue.destination as? EditContactTableViewController {
        let friend = contactsList[indexPath.row]
        // 2
        let store = CNContactStore()
        // 3
        let predicate = CNContact.predicateForContacts(matchingEmailAddress: friend.workEmail)
        // 4
        let keys = [CNContactPhoneNumbersKey as CNKeyDescriptor]
        // 5
        if
          let contacts = try? store.unifiedContacts(matching: predicate, keysToFetch: keys),
          let contact = contacts.first,
          let contactPhone = contact.phoneNumbers.first {
          // 6
            friend.storedContact = contact.mutableCopy() as? CNMutableContact
            friend.phoneNumberField = contactPhone
            friend.identifier = contact.identifier
        }
        editViewController.contact = friend
    }
  }
  
  @IBAction private func addContacts(sender: UIBarButtonItem) {
    // 1
    let contactPicker = CNContactPickerViewController()
    contactPicker.delegate = self
    // 2
    contactPicker.predicateForEnablingContact = NSPredicate(format: "emailAddresses.@count > 0")
    present(contactPicker, animated: true)
  }
  
}

//MARK: - UITableViewDataSource
extension ContactsViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contactsList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
    
    if let cell = cell as? ContactCell {
      let contact = contactsList[indexPath.row]
      cell.contact = contact
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension ContactsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let friend = contactsList[indexPath.row]
    let contact = friend.contactValue
    let contactViewController = CNContactViewController(forUnknownContact: contact)
    contactViewController.hidesBottomBarWhenPushed = true
    contactViewController.allowsEditing = true
    contactViewController.allowsActions = true
    navigationController?.navigationBar.tintColor = .black
    navigationController?.pushViewController(contactViewController, animated: true)
  }
}

//MARK: - CNContactPickerDelegate
extension ContactsViewController: CNContactPickerDelegate {
  func contactPicker(_ picker: CNContactPickerViewController,
                     didSelect contacts: [CNContact]) {
    let newContacts = contacts.compactMap { Contact(contact: $0) }
    for contact in newContacts {
      if !contactsList.contains(contact) {
        contactsList.append(contact)
      }
    }
    tableView.reloadData()
  }
}
