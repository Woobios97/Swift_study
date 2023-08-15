//
//  StationDetailViewController.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/12.
//

import Alamofire
import SnapKit
import UIKit

// 역 상세 정보를 보여주는 뷰 컨트롤러
final class StationDetailViewController: UIViewController {
    private let station: Station // 표시할 역 정보
    private var realTimeArrivalList: [StationArrivalDatResponseModel.RealTimeArrival] = [] // 실시간 도착 정보를 담을 배열
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl() // 새로고침 컨트롤 생성
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)  // 새로고침 시 fetchData() 호출
        return refreshControl
    }()
    
    // 실시간 도착 정보를 보여주는 컬렉션 뷰 생성 및 설정
    private lazy var collectioView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(StationDetailCollectionViewCell.self, forCellWithReuseIdentifier: "StationDetailCollectionViewCell")
        collectionView.dataSource = self
        collectionView.refreshControl = refreshControl // 새로고침 컨트롤을 컬렉션 뷰에 연결
        
        return collectionView
    }()
    
    // 역 정보를 받아 초기화하는 생성자
    init(station: Station) {
        self.station = station
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = station.stationName  // 네비게이션 바 타이틀 설정
        view.addSubview(collectioView) // 뷰에 컬렉션 뷰 추가
        collectioView.snp.makeConstraints { $0.edges.equalToSuperview() } // 컬렉션 뷰를 뷰의 가장자리에 맞춤
        fetchData() // 초기 데이터 요청 및 업데이트
    }
    
    // 데이터 요청 및 업데이트 메서드
    @objc private func fetchData() {
        let stationName = station.stationName
        // 서울 열린데이터 광장 API를 통해 실시간 도착 정보를 가져옴
        let urlString = "http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/\(stationName.replacingOccurrences(of: "역", with: ""))"

        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationArrivalDatResponseModel.self) { [weak self] response in
                self?.refreshControl.endRefreshing() // 새로고침 종료
                guard case .success(let data) = response.result else { return }
                
                self?.realTimeArrivalList = data.realtimeArrivalList // 데이터 업데이트
                self?.collectioView.reloadData() // 컬렉션 뷰 리로드하여 업데이트
            }
            .resume()
    }
}

// 컬렉션 뷰 데이터 소스 정의
extension StationDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realTimeArrivalList.count // 실시간 도착 정보 배열의 개수만큼 아이템 개수 설정
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StationDetailCollectionViewCell", for: indexPath) as? StationDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let realTimeArrival = realTimeArrivalList[indexPath.row] // 해당 인덱스의 실시간 도착 정보 가져오기
        cell.setUP(with: realTimeArrival) // 셀에 정보 설정
        return cell // 생성한 셀 반환
    }
}
