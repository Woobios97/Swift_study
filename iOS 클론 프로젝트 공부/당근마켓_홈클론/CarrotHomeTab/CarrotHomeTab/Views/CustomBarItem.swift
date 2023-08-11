//
//  CustomBarItem.swift
//  CarrotHomeTab
//
//  Created by 김우섭 on 2023/08/10.
//

import Foundation
import UIKit

// init을 정리하기 위해서
// CustomBarItem에 필요한 파라미터를 하나로 묶어서 깔끔하게 관리하기 위해서
struct CustomBarItemConfiguration {
    
    typealias Handler = () -> Void
    
    let title: String?
    let image: UIImage?
    let handler: Handler
    
    init(title: String? = nil, image: UIImage? = nil, handler: @escaping Handler) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}

// CustomBarItem 정리
final class CustomBarItem: UIButton {
    // 타이틀, 이미지, 액션핸들러
    
    var customBarItemConfig: CustomBarItemConfiguration
    
    init(config: CustomBarItemConfiguration) {
        
        self.customBarItemConfig = config
        super.init(frame: .zero)
        setupStyle()
        updateConfig()
        
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupStyle() {
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel?.textColor = .white
        self.imageView?.tintColor = .white
    }
    
    
    private func updateConfig() {
        self.setTitle(customBarItemConfig.title, for: .normal)
        self.setImage(customBarItemConfig.image, for: .normal)
    }
    
    
    @objc func buttonTapped() {
        customBarItemConfig.handler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
