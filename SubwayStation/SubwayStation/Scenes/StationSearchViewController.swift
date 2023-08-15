//
//  StationSearchViewController.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/12.
//
import Alamofire
import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    
    // 지하철 역 정보를 담을 배열
    private var stations: [Station] = []
    
    // 테이블 뷰 생성 및 설정
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true // 초기에는 테이블 뷰를 숨김
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItems() // 네비게이션 바 아이템 설정
        setTableViewLayout() // 테이블 뷰 레이아웃 설정
    }
    
    // 네비게이션 바 아이템 설정
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController() // 검색 컨트롤러 생성
        searchController.searchBar.placeholder = "지하철역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false // 검색 시 배경 흐리지 않게 설정
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController // 네비게이션 바에 검색 컨트롤러 추가
    }
    
    // 테이블 뷰 레이아웃 설정
    private func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() } // 테이블 뷰를 뷰의 가장자리에 맞추기
    }
    
    // 지하철 역 이름으로 정보 요청
    private func requestStationName(from stationName: String) {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result else { return }
                
                self.stations = data.stations // 받아온 역 정보 배열로 저장
                self.tableView.reloadData() // 테이블 뷰 리로드하여 업데이트
            }
            .resume()
    }
}

// 테이블 뷰 셀 선택 시 동작 정의
extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row] // 선택한 역 정보 가져오기
        let vc = StationDetailViewController(station: station) // 역 상세 정보 뷰 컨트롤러 생성
        navigationController?.pushViewController(vc, animated: true) // 뷰 컨트롤러 전환
    }
}

// 서치바 관련 동작 정의
extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData() // 서치바 텍스트 입력 시작 시 테이블 뷰 리로드
        tableView.isHidden = false // 테이블 뷰 보이기
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true // 서치바 텍스트 입력 종료 시 테이블 뷰 숨기기
        stations = [] // 역 정보 초기화
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestStationName(from: searchText) // 입력된 텍스트로 역 정보 요청
    }
}

// 테이블 뷰 데이터 소스 정의
extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count // 역 정보 배열의 개수만큼 행 개수 설정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell") // 재사용 가능한 셀 생성
              let station = stations[indexPath.row] // 해당 인덱스의 역 정보 가져오기
              cell.textLabel?.text = station.stationName // 셀의 주요 텍스트에 역 이름 설정
              cell.detailTextLabel?.text = station.lineNumber // 셀의 부가적인 텍스트에 호선 번호 설정
              return cell // 생성한 셀 반환
          }
}
