import Foundation
import UIKit


struct Constants {
    struct UI {
        struct Images {
            static let personIcon = UIImage(systemName: "person.crop.circle.fill")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
            static let messageIcon = UIImage(systemName: "message.fill")!
            static let callIcon = UIImage(systemName: "phone.fill")!
            static let mailIcon = UIImage(systemName: "envelope.fill")!

        }
        
        struct Layout {
            static let defaultPadding: CGFloat = 16
            static let defaultOffset : CGFloat = 8
            
            static let contactImageHeight : CGFloat = 100
            static let textFieldHeight : CGFloat = 44
            
            static let contentSpacing: CGFloat = 4
        }
    }
    
}
