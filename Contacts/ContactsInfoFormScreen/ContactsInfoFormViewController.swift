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
        imageView.image = UIImage(systemName: "person.circle.fill")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizeStrings.ContactsViewController.addPhoto, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizeStrings.ContactsViewController.cancel, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizeStrings.ContactsViewController.done, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizeStrings.ContactsViewController.create
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizeStrings.ContactsViewController.name
        textField.backgroundColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizeStrings.ContactsViewController.surname
        textField.backgroundColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var companyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = LocalizeStrings.ContactsViewController.company
        textField.backgroundColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var contactTextFieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField,
                                                   surnameTextField,
                                                   companyTextField])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton,
                                                   titleLabel,
                                                   doneButton])
        stack.axis = .horizontal
        stack.spacing = 26
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
    }
    
    @objc func tapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func tapDoneButton() {
        let name = nameTextField.text ?? ""
        let surName = surnameTextField.text ?? ""
        let contact = Contact(name: name, surName: surName)
        delegate?.addContact(contact)
        dismiss(animated: true)
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemGray6
        view.addSubview(photoStackView)
        view.addSubview(contactTextFieldsStack)
        view.addSubview(titleStackView)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.UI.Layout.defaultPadding),
            titleStackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: Constants.UI.Layout.defaultOffset),
            titleStackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -Constants.UI.Layout.defaultOffset),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            
            photoStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: Constants.UI.Layout.defaultPadding),
            photoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
            
            contactImage.heightAnchor.constraint(equalToConstant: 200),
            contactImage.widthAnchor.constraint(equalToConstant: 200),
        

            contactTextFieldsStack.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: Constants.UI.Layout.defaultPadding),
            contactTextFieldsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            contactTextFieldsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.UI.Layout.defaultPadding),
            

            nameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}


// MARK: - UITextFieldDelegate

extension ContactsInfoFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let textRange = Range(range, in: text)
        if let textRange = textRange {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            switch textField.accessibilityLabel {
            case "name_text".localized():
                viewModel.name = updatedText
            case "surname_text".localized():
                viewModel.surname = updatedText
            case "company_text".localized():
                viewModel.company = updatedText
            default: break
            }
//            doneBarButton.isEnabled = viewModel.buttonState
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        nameTextField.placeholder = "name_text".localized()
        surnameTextField.placeholder = "surname_text".localized()
        companyTextField.placeholder = "company_text".localized()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

