import Foundation
import UIKit

class UserAttributeViewCell : UITableViewCell {
    
    static let identifier = "UserAttributeViewCell"

    // MARK: - Views
    var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: UserAttributeViewCell.identifier)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var setTextFieldText: String = "" {
        didSet {
            textField.placeholder = setTextFieldText
        }
    }
    
    private func makeConstraints() {
        contentView.addSubviewForAutoLayout(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.UI.Layout.defaultOffset),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultOffset),
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultPadding)
        ])
    }
}
