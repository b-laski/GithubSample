//
//  GenericViewController.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit
import SnapKit

class GenericViewController<View: GenericView>: UIViewController {
    
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    public var contentView: View {
        return view as! View
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(statusManager),
                                       name: .flagsChanged,
                                       object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func loadView() {
        view = View()
    }
    
}
