import Foundation
import UIKit


extension UIButton {
    func configure(title: String, image: UIImage) {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = image
        config.imagePlacement = .top
        config.imagePadding = 8.0
        config.background.strokeWidth = 4.0
        config.background.backgroundColor = .systemBackground
        config.cornerStyle = .large
        
        self.configuration = config
    }
}
