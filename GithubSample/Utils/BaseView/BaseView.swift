//
//  GenericView.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import Foundation

import UIKit
import SnapKit

class GenericView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {}
}
