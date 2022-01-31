import Foundation

protocol ContactsViewModelDelegate: AnyObject {
    func reloadData()
}

class ContactsViewModel {
    
    weak var delegate: ContactsViewModelDelegate?
    
    var dictionary: [String: [Contact]] = [:]

    var alphabetSigns: [String] {
        return Array(dictionary.keys.sorted(by: { $0 < $1 }))
    }
    
    var allCountContacts: Int = 0
    
    var exampleContactsArray: [Contact] = [
           Contact(name: "Аня", surName: "Приходько"),
           Contact(name: "Алена", surName: "Коробова"),
           Contact(name: "Алексей", surName: "Воеводин"),
           Contact(name: "Диана", surName: "Принцесса"),
           Contact(name: "Дима", surName: "Друг"),
           Contact(name: "Иван", surName: "Умный"),
           Contact(name: "Ира", surName: "Скавчук")
   ]

    func addContact(contact: Contact) {
        let firstLetterIndex = contact.name.index(contact.name.startIndex, offsetBy: 1)
        let contactKey = String(contact.name[..<firstLetterIndex])
            
        if var array = dictionary[contactKey] {
            array.append(contact)
            dictionary[contactKey] = array
        } else {
            dictionary[contactKey] = [contact]
        }
    }
    
    func setStartData() {
        exampleContactsArray.forEach { [weak self] contact in
            self?.addContact(contact: contact)
        }
    }
}
