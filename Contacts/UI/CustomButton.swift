import Foundation
import UIKit

class CustomButton: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    private func setupUserInterface() {
        addSubview(button)
        addSubview(imageView)
        addSubview(titleLabel)
    }

    private func makeConstraints() {
        setupUserInterface()
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: self.widthAnchor),
            button.heightAnchor.constraint(equalTo: self.heightAnchor),

            
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
      func configuration(text: String,systemImageName: String) {
        titleLabel.text = text
        button.setTitle(text, for: .normal)
        imageView.image = UIImage(systemName: systemImageName)
    }
    
}


//BASE CLASS 
