//
//  SplitViewController.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 15/07/2020.
//

import UIKit

class SplitViewController: UISplitViewController {
    init(viewControllers: UIViewController...) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllers = viewControllers
        
        delegate = self
        
        maximumPrimaryColumnWidth = CGFloat(MAXFLOAT);
        preferredPrimaryColumnWidthFraction = 0.5
        preferredDisplayMode = .allVisible
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
