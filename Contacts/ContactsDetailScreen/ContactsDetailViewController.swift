import Foundation
import UIKit

protocol ContactsDetailViewControllerDelegate: AnyObject {
    func changeContact( _ oldContact: Contact, with newContact: Contact)
}

class ContactsDetailViewController: UIViewController {
    
    var viewModel = ContactsDetailViewModel()
    weak var delegate: ContactsDetailViewControllerDelegate?

    //MARK: Views
    private lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.UI.Images.personIcon
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.name
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem(title: LocalizeStrings.ContactsDetailViewController.edit,
                                         style: .plain,
                                         target: self,
                                         action: #selector(tapEditButton))
        return editButton
    }()
    
    private lazy var messageButton: UIButton = {
        let button = CustomButton(title: LocalizeStrings.ContactsDetailViewController.message,
                                  image: Constants.UI.Images.messageIcon)
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = CustomButton(title:  LocalizeStrings.ContactsDetailViewController.call,
                         image: Constants.UI.Images.callIcon)
        return button
    }()
    
    private lazy var mailButton: UIButton = {
        let button = CustomButton(title:  LocalizeStrings.ContactsDetailViewController.mail,
                         image: Constants.UI.Images.mailIcon)
        return button
    }()
    
    
    private lazy var titleBlockStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactImage,
                                                      titleLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.UI.Layout.contentSpacing
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()
    
    
    private lazy var actionButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ messageButton,
                                                        callButton,
                                                        mailButton ])
        stackView.axis = .horizontal
        stackView.spacing = Constants.UI.Layout.contentSpacing
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactDetailViewCell.self,
                           forCellReuseIdentifier: ContactDetailViewCell.identifier)
        return tableView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemGray6

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = editButton
       
        view.addSubviewForAutoLayout(titleBlockStackView)
        view.addSubviewForAutoLayout(actionButtonStackView)
        view.addSubviewForAutoLayout(tableView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleBlockStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleBlockStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contactImage.heightAnchor.constraint(equalToConstant: Constants.UI.Layout.contactImageHeight),
            contactImage.widthAnchor.constraint(equalToConstant: Constants.UI.Layout.contactImageHeight),
            
            actionButtonStackView.topAnchor.constraint(equalTo: titleBlockStackView.bottomAnchor, constant: Constants.UI.Layout.defaultPadding),
            actionButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            actionButtonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.UI.Layout.defaultPadding),
            
            tableView.topAnchor.constraint(equalTo: actionButtonStackView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func tapEditButton() {
        let controller = ContactsInfoFormViewController()
        navigationController?.present(controller, animated: true)
    }
}

// MARK: AddContactsViewControllerDelegate
extension ContactsDetailViewController: ContactsInfoFormViewControllerDelegate {
    func addContact(_ contact: Contact) {
        delegate?.changeContact( viewModel.oldContact! , with: contact)
    }
}


// MARK: UITableViewDataSource
extension ContactsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailViewCell.identifier, for: indexPath) as? ContactDetailViewCell else {
            return  UITableViewCell()
        }
        cell.selectionStyle = .none

        cell.setTextTitleLabel = LocalizeStrings.ContactsDetailViewController.mobile
        cell.setTextContactInfo = viewModel.phoneNumber ?? ""
        return cell
    }
}

// MARK: UITableViewDelegate
extension ContactsDetailViewController: UITableViewDelegate {
    
}

