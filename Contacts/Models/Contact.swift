import Foundation

struct Contact {
    
    var name: String
    var surName: String
    var company: String?
    var image: String = "person.circle.fill"
   
    var fullName: String {
        return "\(name) \(surName)"
    }
    
    var phoneNumber: [Int]?
    var email: [String]?
    
    var sound: String?
    var signal: String?
    
    var urlAdress: [String]?
    var birthday: String?
    var notation: String?
}
