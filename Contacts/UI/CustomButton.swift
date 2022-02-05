import Foundation
import UIKit

class CustomButton: UIButton {
    
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        configure(title: title, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(title: String, image: UIImage) {
        var config = UIButton.Configuration.plain()
        config.subtitle = title
        config.image = image
        config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10)
        config.imagePlacement = .top
        config.imagePadding = Constants.UI.Layout.contentSpacing
        config.background.strokeWidth = 1.0
        config.background.backgroundColor = .systemBackground
        config.cornerStyle = .large
        
        self.configuration = config
    }
}
