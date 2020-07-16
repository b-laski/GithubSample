//
//  UserListViewModel.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import Foundation

protocol UserTableViewModelDelegate: AnyObject {
    func reloadTableView()
    func selectFirstRow()
    func showError(error: String)
}

struct Pagination {
    private var isLoadingMore = false
    
    var currentPage = 1
    var currentQuary = ""
    
    func isLoading() -> Bool {
        return isLoadingMore
    }
    
    mutating func load() {
        self.isLoadingMore = true
        self.currentPage += 1
    }
    
    mutating func loaded() {
        self.isLoadingMore = false
    }
}

final class UserTableViewModel {
    
    var users: Users?
    let requestManager = UserRequestsManager()
    var pagination: Pagination = Pagination()
    
    weak var delegate: UserTableViewModelDelegate?
    
    init(delegate: UserTableViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func searchUsers(quary: String) {
        requestManager.searchUser(username: quary) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.pagination.currentQuary = quary
            switch result {
            case .success(let data):
                strongSelf.users = data
                strongSelf.delegate?.reloadTableView()
                strongSelf.delegate?.selectFirstRow()
            case .failure(let error):
                strongSelf.delegate?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func getMoreUsers() {
        if pagination.isLoading() || users?.totalCount == users?.items?.count {
            return
        }
        
        pagination.load()
        requestManager.getMoreUsers(username: pagination.currentQuary, page: pagination.currentPage) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.pagination.loaded()
            switch result {
            case .success(let data):
                strongSelf.users?.items?.append(contentsOf: data.items ?? [])
                strongSelf.delegate?.reloadTableView()
            case .failure(let error):
                strongSelf.delegate?.showError(error: error.localizedDescription)
            }
        }
    }
}
