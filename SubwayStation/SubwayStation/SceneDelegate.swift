//
//  SceneDelegate.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController: StationSearchViewController()) // -> 네비게이션바에 네비게이션아이템으로 UISearchController를 임베디드 시켜줘야한다.
        window?.makeKeyAndVisible()
    }
}

