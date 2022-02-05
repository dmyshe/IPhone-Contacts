
class ContactsInfoFormViewModel {
    var image: String?
    
    var name = ""
    var surname = ""
    var company = ""
    
    var buttonState: Bool {
        return !name.isEmpty || !surname.isEmpty || !company.isEmpty
    }
    
    let textfieldPlaceholderText = [
        LocalizeStrings.ContactsInfoFormViewController.name,
        LocalizeStrings.ContactsInfoFormViewController.surname,
        LocalizeStrings.ContactsInfoFormViewController.company
    ]
}
