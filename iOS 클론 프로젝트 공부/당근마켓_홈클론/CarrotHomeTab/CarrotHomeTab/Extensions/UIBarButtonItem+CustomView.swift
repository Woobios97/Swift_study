//
//  UIBarButtonItem+CustomView.swift
//  CarrotHomeTab
//
//  Created by 김우섭 on 2023/08/11.
//

import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfiguration, width: CGFloat? = nil) -> UIBarButtonItem {
        let customView = CustomBarItem(config: config)
        if let width = width {
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
    }
}
