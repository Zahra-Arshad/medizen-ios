//
//  EditContactTableViewController.swift
//  medizen
//
//  Created by  on 4/1/21.
//

import UIKit
import Contacts

class EditContactTableViewController: UITableViewController {
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var phoneTypeLabel: UILabel!
  @IBOutlet private weak var phoneTextField: UITextField!
  @IBOutlet private weak var saveButton: UIButton!

  var contact: Contact?

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    guard let contact = contact else {
      nameLabel.text = ""
      emailLabel.text = ""
      phoneTextField.text = ""
      phoneTextField.isEnabled = false
      return
    }
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    if let name = formatter.string(from: contact.contactValue) {
      nameLabel.text = name
    } else {
      nameLabel.text = "Name Not Available"
    }
    emailLabel.text = contact.workEmail
    if let phoneNumberField = contact.phoneNumberField,
      let label = phoneNumberField.label {
      phoneTypeLabel.text = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
      phoneTextField.text = phoneNumberField.value.stringValue
    }
  }

  @IBAction private func save(_ sender: Any) {
    phoneTextField.resignFirstResponder()
    let store = CNContactStore()
    guard let contact = contact,
      let phoneNumberText = phoneTextField.text else { return }
    let phoneNumberValue = CNPhoneNumber(stringValue: phoneNumberText)
    let saveRequest = CNSaveRequest()
    
    if let storedContact = contact.storedContact,
      let phoneNumberToEdit = storedContact.phoneNumbers.first(
        where: { $0 == contact.phoneNumberField }
      ),
      let index = storedContact.phoneNumbers.firstIndex(of: phoneNumberToEdit) {
      
      // 1
      let newPhoneNumberField = phoneNumberToEdit.settingValue(phoneNumberValue)
      storedContact.phoneNumbers.remove(at: index)
      storedContact.phoneNumbers.insert(newPhoneNumberField, at: index)
        contact.phoneNumberField = newPhoneNumberField
      // 2
      saveRequest.update(storedContact)
        contact.storedContact = nil
    } else if let unsavedContact = contact.contactValue.mutableCopy() as? CNMutableContact {
      // 3
      let phoneNumberField = CNLabeledValue(label: CNLabelPhoneNumberMain,
                                            value: phoneNumberValue)
      unsavedContact.phoneNumbers = [phoneNumberField]
        contact.phoneNumberField = phoneNumberField
      // 4
      saveRequest.add(unsavedContact, toContainerWithIdentifier: nil)
    }

    do {
      try store.execute(saveRequest)
      let controller = UIAlertController(title: "Success",
                                         message: nil,
                                         preferredStyle: .alert)
      controller.addAction(UIAlertAction(title: "OK", style: .default))
      present(controller, animated: true)
      setup()
    } catch {
      print(error)
    }
  }
}
