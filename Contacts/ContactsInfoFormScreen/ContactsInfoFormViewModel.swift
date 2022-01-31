import UIKit

class ContactsInfoFormViewModel {
    var image: UIImage?
    
    var name = ""
    var surname = ""
    var company = ""
    
    var buttonState: Bool {
        return !name.isEmpty || !surname.isEmpty || !company.isEmpty
    }
    
    let textFieldPlaceholderName = [
        LocalizeStrings.ContactsInfoFormViewController.name,
        LocalizeStrings.ContactsInfoFormViewController.surname,
        LocalizeStrings.ContactsInfoFormViewController.company
    ]
}
