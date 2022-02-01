import UIKit

class ContactsViewController: UIViewController {
    
    var viewModel = ContactsViewModel()
    
    //MARK: Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(NumberOfContactsViewCell.self, forCellReuseIdentifier: NumberOfContactsViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searсhController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = LocalizeStrings.ContactsViewController.search
        return searchController
    }()
    
    private lazy var addButton: UIBarButtonItem = {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(tapAddButton))
        return addButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
        viewModel.setStartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemBackground
        
        title = LocalizeStrings.ContactsViewController.contactsTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addButton
        navigationItem.searchController = searсhController

        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func tapAddButton() {
        let controller = ContactsInfoFormViewController()
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        navigationController?.present(navController, animated: true)
    }
}

// MARK: - AddContactsViewControllerDelegate
extension ContactsViewController: ContactsInfoFormViewControllerDelegate {
    func addContact(_ contact: Contact) {
        viewModel.addContact(contact: contact)
        tableView.reloadData()
    }
}

// MARK: -  UITableViewDataSource

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.alphabetSigns[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.alphabetSigns
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.alphabetSigns.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sign = viewModel.alphabetSigns[section]
        let rowCount = viewModel.dictionary[sign]?.count ?? 0

        return section == tableView.numberOfSections - 1 ? rowCount + 1 : rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == tableView.numberOfSections - 1,
           indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1,
           let cell = tableView.dequeueReusableCell(withIdentifier: NumberOfContactsViewCell.identifier, for: indexPath) as? NumberOfContactsViewCell {
            cell.isUserInteractionEnabled = false
            
            viewModel.countAllContacts(with: tableView)
            
            let countConctactsNumber = viewModel.allCountContacts
            cell.setText("\(countConctactsNumber) \(LocalizeStrings.ContactsViewController.contactsText)")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sign = viewModel.alphabetSigns[indexPath.section]
        let contact = (viewModel.dictionary[sign] ?? [])[indexPath.row]
        cell.textLabel?.text = contact.fullName
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sign = viewModel.alphabetSigns[indexPath.section]
        
        if let names = viewModel.dictionary[sign] {
            let selectedName = names[indexPath.row].fullName
            
            let controller = ContactsDetailViewController()
            controller.delegate = self
            controller.viewModel.name = selectedName
            
            let phoneNumber = names[indexPath.row].phoneNumber?.first ?? 0
            controller.viewModel.number = String("+\(phoneNumber )")
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}

// MARK: - UISearchResultsUpdating
extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - ContactsDetailViewControllerDelegate
extension ContactsViewController: ContactsDetailViewControllerDelegate {
    func changeContact(oldContact: Contact, with newContact: Contact) {
    }

}
