//
//  UserRequestsManager.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import Foundation

protocol UserRequestsManagerProtocol: class {
    func searchUser(username: String, completion: @escaping (Result<Users, Error>) -> Void)
    func getMoreUsers(username: String, page: Int, completion: @escaping (Result<Users, Error>) -> Void)
}

final class UserRequestsManager: UserRequestsManagerProtocol {
    private let httpHandler = HTTPHandler()
    
    func searchUser(username: String, completion: @escaping (Result<Users, Error>) -> Void) {
        let request = UserRequests.searchUsers(parameters: SearchParams(q: username))
        
        httpHandler.make(request: request) { ( result: Result<Users, Error>) in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMoreUsers(username: String, page: Int, completion: @escaping (Result<Users, Error>) -> Void) {
        let request = UserRequests.searchUsers(parameters: SearchParams(q: username, page: page))
        
        httpHandler.make(request: request) { ( result: Result<Users, Error>) in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
