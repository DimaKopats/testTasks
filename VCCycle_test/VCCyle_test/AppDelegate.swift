//
//  AppDelegate.swift
//  VCCyle_test
//
//  Created by Dzmitry Kopats on 11/14/17.
//  Copyright © 2017 Dzmitry Kopats. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let redVC = "❤️"
        let greenVC = "💚"
        let yellowVC = "💛"
        let blueVC = "💙"
        
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        let viewController1 = ViewController()
        let viewController2 = ViewController()
        let viewController3 = ViewController()
        let viewController4 = ViewController()
        
        viewController1.color = .green
        viewController2.color = .red
        viewController3.color = .blue
        viewController4.color = .yellow
        
        viewController1.stringColor = greenVC
        viewController2.stringColor = redVC
        viewController3.stringColor = blueVC
        viewController4.stringColor = yellowVC
        
        viewController2.view.backgroundColor = .black
        
        let controllersStack: [UIViewController] = [viewController1, viewController2, viewController3, viewController4]
        
        
        
        
        let naviController = UINavigationController.init()
        naviController.setViewControllers(controllersStack, animated: true)
        self.window?.rootViewController = naviController
        self.window?.makeKeyAndVisible()
//
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

