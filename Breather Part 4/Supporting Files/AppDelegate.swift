//
//  AppDelegate.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        if let navigationController = window?.rootViewController as? UINavigationController,
            let mainViewController = navigationController.topViewController as? MainViewController {
            mainViewController.viewModel = MainViewModel()
        }
    }
}
