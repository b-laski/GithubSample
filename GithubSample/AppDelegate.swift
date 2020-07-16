//
//  AppDelegate.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        HTTPHandlerLogger.shared.startLogging()
        try? Network.reachability = Reachability(hostname: "www.google.com")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = prepareSplitViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    private func prepareSplitViewController() -> UISplitViewController {
        let userTableViewController = UINavigationController(rootViewController: UserTableViewController())
        let splitViewController = SplitViewController(viewControllers: userTableViewController)
        
        return splitViewController
    }
}
