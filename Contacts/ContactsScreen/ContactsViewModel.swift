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
           Contact(name: "Аня", surName: "Приходько", phoneNumber: [38044833321]),
           Contact(name: "Алена", surName: "Коробова", phoneNumber: [38050933234]),
           Contact(name: "Алексей", surName: "Воеводин", phoneNumber: [380509344234]),
           Contact(name: "Диана", surName: "Принцесса", phoneNumber: [38040933321]),
           Contact(name: "Дима", surName: "Друг", phoneNumber: [38044833321]),
           Contact(name: "Иван", surName: "Умный", phoneNumber: [38044833321]),
           Contact(name: "Ира", surName: "Скавчук", phoneNumber: [380448323321])
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
    
    func countAllContacts(with tableView: UITableView) {
        var allCounts = 0
        for i in 0..<tableView.numberOfSections {
            allCounts += tableView.numberOfRows(inSection: i)
        }
       allCountContacts = allCounts - 1
    }
    
    func setStartData() {
        exampleContactsArray.forEach { [weak self] contact in
            self?.addContact(contact: contact)
        }
    }
}
