//
//  ViewController.swift
//  PageMenu
//
//  Created by KentarOu on 2016/09/03.
//  Copyright © 2016年 KentarOu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func pushNext(sender: UIButton) {
        let pageMenu = storyboard?.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
        
        let vc1 = storyboard?.instantiateViewControllerWithIdentifier("vc1") as! ViewController1
        let vc2 = storyboard?.instantiateViewControllerWithIdentifier("vc2") as! ViewController2
        let vc3 = storyboard?.instantiateViewControllerWithIdentifier("vc3") as! ViewController3
        
        // pageMenu.isInfinity = true
        pageMenu._baseViewTopConstraint = 64
        pageMenu.tabItems = [(vc1, "VC1"), (vc2, "VC2"), (vc3, "VC3")]
        
        navigationController?.pushViewController(pageMenu, animated: true)
    }
}

