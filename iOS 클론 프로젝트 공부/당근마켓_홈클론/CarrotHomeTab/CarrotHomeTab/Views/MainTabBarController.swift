//
//  MainTabBarController.swift
//  CarrotHomeTab
//
//  Created by 김우섭 on 2023/08/10.
//

import UIKit

// [ ✅ ] 탭이 눌릴 때마다, 그에 맞는 네비게이션 바를 구성하고싶다.
//  1) [ ✅ ] 탭이 눌린 것을 감지 해야한다.
//  2) [ ✅ ] 감지 후에, 그 탭에 맞게 네비게이션 바 구성을 업데이트 해줘야한다.

// UIBarButtonItem을 커스텀으로 구성하고 싶다. 그리고 사용자와의 인터렉션이 되게 하고싶다면?
// 앱이 시작할 때, 네비게이션바 아이템 설정을 완료하고 싶다면?
// 1) 네비게이션바를 어떤 뷰컨으로 세팅할 지 정해야한다. -> selectedViewController

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    
    // 탭바컨트롤러가 보여지기 시작하는 시점에, 뷰가 보여지기 직전(viewWillAppear)에는 nil이 아니다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationItem(vc: self.selectedViewController!)
    }
    
    private func updateNavigationItem(vc: UIViewController) {
        switch vc {
        case is HomeViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "낙양동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let searchConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "magnifyingglass"),
                handler: { print("--> search tapped") }
            )
            
            let searchItem = UIBarButtonItem.generate(with: searchConfig, width: 30)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("--> feed tapped") }
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            // BarItem을 left/rightBarButtonItems로 여러개 설정할 수 있다.
            navigationItem.rightBarButtonItems = [feedItem, searchItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyTownViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "낙양동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("--> feed tapped") }
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is ChatViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "채팅",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "bell"),
                handler: { print("--> feed tapped") }
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            navigationItem.backButtonDisplayMode = .minimal
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfiguration(
                title: "나의 당근",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let settingConfig = CustomBarItemConfiguration(
                image: UIImage(systemName: "gearshape"),
                handler: { print("--> setting tapped") }
            )
            
            let settingItem = UIBarButtonItem.generate(with: settingConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [settingItem]
            navigationItem.backButtonDisplayMode = .minimal
        default:
            let titleConfig = CustomBarItemConfiguration(
                title: "낙양동",
                handler: {}
            )
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = []
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
}

// [✅] 각 탭에 맞게 네비게이션바 아이템 구성하기
// - ✅ 홈: 타이틀, 피드, 서치
// - ✅ 동네활동: 타이틀, 피드
// - ✅ 내 근처: 타이틀
// - ✅ 채팅: 타이틀, 피드
// - ✅ 나의 당근: 타이틀, 설정

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigationItem(vc: viewController)
    }
}
