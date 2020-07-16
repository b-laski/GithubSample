//
//  UserTableView.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit

class UserTableView: GenericView {
    
    // MARK: - Components -
    let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    
    // MARK: - Methods -
    override func configureView() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
