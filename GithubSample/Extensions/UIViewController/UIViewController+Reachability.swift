//
//  UIViewController+Reachability.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 16/07/2020.
//

import UIKit

extension UIViewController {    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            let alert = UIAlertController(title: Translate.problemWithInternetTitle, message: Translate.problemWithInternetDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        case .wwan, .wifi:
            break
        }
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
}

private extension UIViewController {
    struct Translate {
        static let problemWithInternetTitle = "Problem z internetem"
        static let problemWithInternetDescription = "Nie masz połączenia z internetem."
    }
}
