//
//  TabBarController.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if let viewControllers = self.viewControllers where viewControllers.count >= 2, 
            let foodNavController = viewControllers[0] as? UINavigationController where foodNavController.viewControllers.count > 0, 
            let foodViewController = foodNavController.viewControllers[0] as? ListingsViewController, 
            let drinksNavController = viewControllers[1] as? UINavigationController where drinksNavController.viewControllers.count > 0, 
            let drinksViewController = drinksNavController.viewControllers[0] as? ListingsViewController {

            foodViewController.state = ListingsViewController.State.Food
            drinksViewController.state = ListingsViewController.State.Drinks
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
