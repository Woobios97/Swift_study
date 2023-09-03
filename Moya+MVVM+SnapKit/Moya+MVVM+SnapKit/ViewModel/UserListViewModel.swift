//
//  UserListViewModel.swift
//  Moya+MVVM+SnapKit
//
//  Created by 김우섭 on 2023/09/03.
//

import Foundation
import Moya

/*
 - UserListViewModel : 사용자 데이터를 가져오고 테이블 뷰를 갱신하기 위한 ViewModel입니다.
 - fetchUsers : Moya를 사용하여 사용자 목록을 가져와 'users' 배열에 저장하고, 'reloadTableViewClosure' 클로저를 호출하여 테이블 뷰를 갱신 요청합니다.
 */

class UserListViewModel {
    private let provider = MoyaProvider<GitHubService>()
    var users: [User] = [] // 사용자 데이터를 저장할 배열
    var reloadTableViewClosure: (() -> Void)? // 테이블 뷰 갱신을 알리기 위한 클로저
    
    func fetchUser() {
        provider.request(.getUsers) { [weak self] result in
            switch result {
            case let .success(response):
                do {
                    let fetchedUsers = try response.map([User].self)
                    self?.users = fetchedUsers // 사용할 데이터 저장
                    self?.reloadTableViewClosure?() // 테이블뷰 갱신 요청
                } catch {
                    print("This is Mapping Error: \(error)")
                }
            case let .failure(error):
                print("This is Networking Error: \(error)")
            }
        }
    }
    
    
}
