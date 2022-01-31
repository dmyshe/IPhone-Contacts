import Foundation
import UIKit

protocol ContactsDetailViewControllerDelegate: AnyObject {
    func changeContact(oldContact: Contact, with newContact: Contact)
}

class ContactsDetailViewController: UIViewController {
    
    var viewModel = ContactsDetailViewModel()
    weak var delegate: ContactsDetailViewControllerDelegate?

    //MARK: Views
    private lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.UI.Images.personIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
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
        let button = UIButton()
        button.configure(title: "message", systemImage: "message.fill")
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.configure(title: "call", systemImage: "phone.fill")
        return button
    }()
    
    private lazy var mailButton: UIButton = {
        let button = UIButton()
        button.configure(title: "mail", systemImage: "envelope.fill")
        return button
    }()
    
    private lazy var titleBlockStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactImage,
                                                      titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var actionButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ messageButton,
                                                        callButton,
                                                        mailButton ])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = editButton
       
        view.addSubview(titleBlockStackView)
        view.addSubview(actionButtonStackView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            titleBlockStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleBlockStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contactImage.heightAnchor.constraint(equalToConstant: Constants.UI.Layout.contactImageHeight),
            contactImage.widthAnchor.constraint(equalToConstant: Constants.UI.Layout.contactImageHeight),
            
            actionButtonStackView.topAnchor.constraint(equalTo: titleBlockStackView.bottomAnchor, constant: Constants.UI.Layout.defaultPadding),
            actionButtonStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            actionButtonStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.UI.Layout.defaultPadding)
            
            
            
            
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
        delegate?.changeContact(oldContact: viewModel.oldContact! , with: contact)
    }
}
