//
//  AppDelegate.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/14/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setOnboardingScreen()
        return true
    }

    
    private func setOnboardingScreen(){
        let ingredientInputViewController = IngredientInputViewController()
        let navigationController = UINavigationController(rootViewController: ingredientInputViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

