//
//  DetailView.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 15/07/2020.
//

import UIKit

class DetailView: GenericView {
    // MARK: - Components -
    let profileImage: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    let profileName: UILabel = UILabel.centerBold32
    
    // MARK: - Private Methods -
    override func configureView() {
        addSubview(profileImage)
        addSubview(profileName)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        profileImage.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Layout.profileNameTopMargin)
            make.centerX.equalToSuperview()
            make.size.equalTo(Layout.profileImageSize)
        }
        
        profileName.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(Layout.profileNameTopMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
}

private extension DetailView {
    struct Layout {
        static let profileImageTopMargin: CGFloat = 16
        static let profileImageSize: CGSize = CGSize(width: 128, height: 128)
        
        static let profileNameTopMargin: CGFloat = 16
    }
}
