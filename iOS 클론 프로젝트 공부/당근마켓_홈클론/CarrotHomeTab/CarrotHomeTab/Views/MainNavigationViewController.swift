//
//  MainNavigationViewController.swift
//  CarrotHomeTab
//
//  Created by 김우섭 on 2023/08/10.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(systemName: "arrow.backward")
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.tintColor = .white

    }
}
