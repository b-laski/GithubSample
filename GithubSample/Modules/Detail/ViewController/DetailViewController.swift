//
//  DetailViewController.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 15/07/2020.
//

import UIKit
import moa

class DetailViewController: GenericViewController<DetailView> {
    
    private let detailViewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        detailViewModel = viewModel
        super.init()
        
        title = Translates.title
        fetchData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchData() {
        contentView.profileImage.moa.url = detailViewModel.user.avatarURL
        contentView.profileName.text = detailViewModel.user.login
    }
}

private extension DetailViewController {
    struct Translates {
        static let title = "Detale"
    }
}
