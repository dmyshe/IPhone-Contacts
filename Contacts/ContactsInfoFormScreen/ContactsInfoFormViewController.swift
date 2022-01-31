import Foundation
import UIKit

protocol ContactsInfoFormViewControllerDelegate: AnyObject {
    func addContact(_ contact: Contact)
}

class ContactsInfoFormViewController: UIViewController {
    
    let viewModel = ContactsInfoFormViewModel()
    weak var delegate: ContactsInfoFormViewControllerDelegate?
    
    //MARK: Views
    private lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.UI.Images.personIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizeStrings.ContactsInfoFormViewController.addPhoto, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: LocalizeStrings.ContactsInfoFormViewController.cancel,
                                     style: .plain,
                                     target: self,
                                     action: #selector(tapCancelButton))
        return button
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: LocalizeStrings.ContactsInfoFormViewController.done,
                                     style: .plain,
                                     target: self,
                                     action: #selector(tapDoneButton))
        return button
    }()

    private lazy var photoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [contactImage,
                                                   addImageButton])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserAttributeViewCell.self,
                           forCellReuseIdentifier: UserAttributeViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
    }
    
    @objc func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func tapDoneButton() {
        let name =  viewModel.name
        let surName = viewModel.surname
        let contact = Contact(name: name, surName: surName)
        delegate?.addContact(contact)
        dismiss(animated: true)
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemGray6
        
        title = LocalizeStrings.ContactsInfoFormViewController.create
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = doneButton
        
        view.addSubview(photoStackView)
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            photoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.UI.Layout.defaultPadding),
            photoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contactImage.heightAnchor.constraint(equalToConstant: 200),
            contactImage.widthAnchor.constraint(equalToConstant: 200),
      
            tableView.topAnchor.constraint(equalTo: photoStackView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension ContactsInfoFormViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let textRange = Range(range, in: text)
        if let textRange = textRange {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            let textFieldType = TextFieldType(rawValue: textField.tag)
            
            switch textFieldType {
            case .name:
                viewModel.name = updatedText
            case .surname:
                viewModel.surname = updatedText
            case .company:
                viewModel.company = updatedText
            default:
                print("nothing")
            }
            doneButton.isEnabled = viewModel.buttonState
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: UITableViewDataSource
extension ContactsInfoFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.textFieldPlaceholderName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserAttributeViewCell.identifier, for: indexPath) as? UserAttributeViewCell else {
            return  UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.textField.tag = indexPath.row
        cell.textField.delegate = self

        let placeholderText = viewModel.textFieldPlaceholderName[indexPath.row]
        cell.setPlaceholderText(placeholderText)
        return cell
    }
}

// MARK: UITableViewDelegate
extension ContactsInfoFormViewController: UITableViewDelegate {
    
}



