//
//  UserListViewController.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit
import moa

class UserTableViewController: GenericViewController<UserTableView> {
    
    private let userTableViewModel: UserTableViewModel
    
    init(userTableViewModel: UserTableViewModel = UserTableViewModel()) {
        self.userTableViewModel = userTableViewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Translates.title
        
        self.userTableViewModel.delegate = self
        
        setupTableView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesBottomBarWhenPushed = true
        searchController.searchBar.placeholder = Translates.searchBarPlaceholder
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.keyboardDismissMode = .onDrag
        contentView.tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
    }

}

extension UserTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTableViewModel.users?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        cell.profileImage.moa.url = userTableViewModel.users?.items?[indexPath.item].avatarURL
        cell.profileName.text = userTableViewModel.users?.items?[indexPath.item].login
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = userTableViewModel.users?.items?[indexPath.row] {
            let vm = DetailViewModel(user: user)
            let vc = UINavigationController(rootViewController: DetailViewController(viewModel: vm))
            splitViewController?.showDetailViewController(vc, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Layer.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let lastElement = userTableViewModel.users?.items?.count else { return }
        if indexPath.row == lastElement - 1 {
            userTableViewModel.getMoreUsers()
        }
    }
}

extension UserTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchingQuary = searchBar.text,
                  !searchingQuary.isEmpty else { return }
            
        userTableViewModel.searchUsers(quary: searchingQuary)
    }
}

extension UserTableViewController: UserTableViewModelDelegate {
    func reloadTableView() {
        contentView.tableView.reloadData()
    }
    
    func selectFirstRow() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let rowToSelect: IndexPath = IndexPath(row: 0, section: 0)
            contentView.tableView.selectRow(at: rowToSelect, animated: false, scrollPosition: .top)
            tableView(contentView.tableView, didSelectRowAt: rowToSelect)
        }
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

private extension UserTableViewController {
    struct Translates {
        static let title = "Użytkownicy"
        static let searchBarPlaceholder = "Szukaj użytkownika"
    }
    
    struct Layer {
        static let cellHeight: CGFloat = 50
    }
}
