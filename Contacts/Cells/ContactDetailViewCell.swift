import Foundation
import UIKit

class ContactDetailViewCell : UITableViewCell {
    
    static let identifier = "ContactDetailViewCell"
    
    // MARK: Views
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var contactInfo: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cellContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   contactInfo])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: UserAttributeViewCell.identifier)
        setupUserInterface()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUserInterface() {
        contentView.addSubview(cellContentStackView)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            cellContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultOffset)
        ])
    }
}
