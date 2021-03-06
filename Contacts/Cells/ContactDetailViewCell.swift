import Foundation
import UIKit

class ContactDetailViewCell : UITableViewCell {
    
    static let identifier = "ContactDetailViewCell"
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private lazy var contactInfo: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var cellContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   contactInfo])
        stack.axis = .vertical
        stack.spacing = Constants.UI.Layout.contentSpacing
        stack.distribution = .equalCentering
        stack.alignment = .leading
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
    
    var setTextTitleLabel: String = "" {
        didSet {
            titleLabel.text = setTextTitleLabel
        }
    }
    var setTextContactInfo: String = "" {
        didSet {
            contactInfo.setTitle(setTextContactInfo, for: .normal)
        }
    }

    private func setupUserInterface() {
        contentView.addSubviewForAutoLayout(cellContentStackView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cellContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultOffset)
        ])
    }
}
