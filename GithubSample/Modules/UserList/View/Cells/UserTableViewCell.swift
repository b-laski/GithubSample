//
//  UserTableViewCell.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return "\(UserTableViewCell.self)"
    }
    
    // MARK: - Components -
    let profileImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let profileName: UILabel = UILabel.bold18
    
    // MARK: -Lifecycle view -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods -
    private func configureView() {
        addSubview(profileImage)
        addSubview(profileName)
        
        profileImage.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(Layout.profileImageLeftMargin)
            make.centerY.equalToSuperview()
            make.size.equalTo(Layout.profileImageSize)
        }
        
        profileName.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalTo(profileImage.snp.trailing).offset(Layout.profileNameLeftMargin)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
}

private extension UserTableViewCell {
    struct Layout {
        static let profileImageLeftMargin: CGFloat = 16
        static let profileImageSize: CGSize = CGSize(width: 32, height: 32)
        
        static let profileNameLeftMargin: CGFloat = 8
    }

}
