import Foundation
import UIKit


extension UIButton {
    func configure(title: String, systemImage: String) {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = UIImage(systemName: systemImage)
        config.imagePlacement = .top
        config.imagePadding = 8.0
        config.background.strokeWidth = 4.0
        config.background.backgroundColor = .systemGray6
        config.cornerStyle = .large
        
        self.configuration = config
    }
}
