import UIKit

class NumberOfContactsViewCell: UITableViewCell {
    
    static let identifier = "NumberOfContactsViewCell"
    
    // MARK: Views
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: NumberOfContactsViewCell.identifier)
        
        contentView.addSubviewForAutoLayout(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.UI.Layout.defaultPadding),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultPadding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        label.text = text
    }

}
