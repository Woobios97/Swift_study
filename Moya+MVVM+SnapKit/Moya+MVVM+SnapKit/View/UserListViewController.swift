//
//  UserListViewController.swift
//  Moya+MVVM+SnapKit
//
//  Created by 김우섭 on 2023/09/03.
//

/*
 UserListViewController : 사용자 목록을 표시하는 뷰 컨트롤러입니다.
 setupUI : 테이블뷰를 생성하고 AutoLayout 제약을 설정합니다.
 bindViewModel : ViewModel의 'reloadTableViewClosure' 클로저를 연결하여 테이블뷰를 갱신합니다.
 */


import UIKit
import SnapKit

class UserListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUser()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 테이블 뷰를 화면 가득 채우도록 설정
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData() // 테이블뷰 갱신
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count // 사용자 수에 따라 행 수 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.login // 사용자 이름 표시
        return cell
    }    
}
