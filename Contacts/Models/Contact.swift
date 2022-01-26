import UIKit

struct Contact {
    
    var name: String
    var surName: String
    var company: String?
    var image: UIImage = UIImage(systemName: "person.circle.fill")!
   
    var fullName: String {
        return "\(name) \(surName)"
    }
    
    var phoneNumber: [String]?
    var email: [String]?
    
    var melody: String?
    var signal: String?
    
    var urlAdress: [String]?
    var birthday: String?
    var notation: String?
}
