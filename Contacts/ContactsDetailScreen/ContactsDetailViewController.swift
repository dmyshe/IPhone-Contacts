import Foundation
import UIKit


protocol ContactsDetailViewControllerDelegate: AnyObject {
    func changeContact(oldContact: Contact, with newContact: Contact)
}

class ContactsDetailViewController: UIViewController {
    
    var viewModel = ContactsDetailViewModel()
    weak var delegate: ContactsDetailViewControllerDelegate?
    
    var oldContact: Contact?

    //MARK: Views
    private lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem(title: LocalizeStrings.ContactsViewController.edit,
                                         style: .plain,
                                         target: self,
                                         action: #selector(addTapped))
        return editButton
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
       
        view.addSubview(contactImage)
    }
    
    private func makeConstraints() {

        NSLayoutConstraint.activate([
            contactImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactImage.heightAnchor.constraint(equalToConstant: 100),
            contactImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func addTapped() {
        let controller = ContactsInfoFormViewController()
        navigationController?.present(controller, animated: true)
    }
}

// MARK: AddContactsViewControllerDelegate
extension ContactsDetailViewController: ContactsInfoFormViewControllerDelegate {
    func addContact(_ contact: Contact) {
        delegate?.changeContact(oldContact: oldContact! , with: contact)
    }
}
