//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // initialize container view with container presenter
        // this would hold all logic for sidepanel movement and 
        let serviceLayer = ServiceLayer()
        let containerPresenter = ContainerPresenter(serviceLayer)
        let container = Container(containerPresenter)
        
        window?.rootViewController = container
        window?.makeKeyAndVisible()
        print("commited to you")
        return true
    }
}

