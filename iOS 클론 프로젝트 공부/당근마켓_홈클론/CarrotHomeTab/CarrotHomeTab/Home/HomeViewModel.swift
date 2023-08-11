//
//  HomeViewModel.swift
//  CarrotHomeTab
//
//  Created by 김우섭 on 2023/08/11.
//

import Foundation
import Combine

final class HomeViewModel {
    // 뷰모델은 리스트 가져오기 -> 네트워크롤 통해서 가져온다. 따라서 네트워크 서비스가 필요하다.
    let network: NetworkService
    
    // 네트워크 서비스를 통해 가져온 아이템들은 아이템인포 -> 초기에는 빈깡통
    // Published로 만들어서 실제로 뷰컨에게 바인딩할 수 있게끔 만들어놓는다.
    @Published var items: [ItemInfo] = []
    var subscriptions = Set<AnyCancellable>()
    
    // 아이템 클릭했을 때
    let itemTapped = PassthroughSubject<ItemInfo, Never>()
    
    
    init(network: NetworkService) {
        self.network = network
    }
    
    // fetch를 통해서 아이템들을 받아오는 것을 작성해줘야한다.
    // 서버에 있는 정보들을 요청한 다음에, 받기위한 것(디코딩)
    // 정보가 서버 어딘가에 있는데, 그 힌트를 줘야한다는 것.
    func fetch() {
        let resource: Resource<[ItemInfo]> = Resource(
            base: "https://my-json-server.typicode.com/",
            path: "cafielo/demo/products",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("--> error: \(error)")
                case .finished:
                    print("--> finished")
                }
            } receiveValue: { items in
                self.items = items
            }.store(in: &subscriptions)
    }
}
