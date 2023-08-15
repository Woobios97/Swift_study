//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/13.
//

// StationResponseModel().searchInfo.row -> 실제로 사용하려고 할 때
// StationResponseModel.stations

import Foundation

// 서버 응답 데이터를 파싱하는 모델: 역 정보 응답 모델
struct StationResponseModel: Decodable {
    var stations: [Station] { searchInfo.row } // stations 프로퍼티는 searchInfo의 row로 설정
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService" // JSON에서 "SearchInfoBySubwayNameService" 키에 해당하는 값을 파싱
    }
    
    // 서버 응답 데이터 중에서 실제 역 정보를 담는 부분
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = [] // 역 정보를 담을 배열로 초기화
    }
}

// 역 정보 모델
struct Station: Decodable {
    let stationName: String // 역 이름
    let lineNumber: String // 노선 번호
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM" // JSON에서 "STATION_NM" 키에 해당하는 값을 역 이름으로 파싱
        case lineNumber = "LINE_NUM" // JSON에서 "LINE_NUM" 키에 해당하는 값을 노선 번호로 파싱
    }
}

