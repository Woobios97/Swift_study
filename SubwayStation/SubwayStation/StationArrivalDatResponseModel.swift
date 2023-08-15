//
//  StationArrivalDatResponseModel.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/13.
//

import Foundation

// 서버 응답 데이터를 파싱하는 모델: 실시간 도착 정보 응답 모델
struct StationArrivalDatResponseModel: Decodable {
    var realtimeArrivalList: [RealTimeArrival] // 실시간 도착 정보 배열
    
    // 실시간 도착 정보 모델
    struct RealTimeArrival: Decodable {
        let line: String // 열차 노선 정보 (예: 2호선)
        let remainTime: String // 도착까지 남은 시간 및 전역 출발 여부 (예: 2분 후 of 전역 출발)
        let currentStation: String // 현재 열차 위치 (예: 강남역)
        
        enum CodingKeys: String, CodingKey {
            case line = "trainLineNM" // JSON에서 "trainLineNM" 키에 해당하는 값을 열차 노선 정보로 파싱
            case remainTime = "arvlMsg2" // JSON에서 "arvlMsg2" 키에 해당하는 값을 도착까지 남은 시간 및 전역 출발 여부로 파싱
            case currentStation = "arvlMsg3" // JSON에서 "arvlMsg3" 키에 해당하는 값을 현재 열차 위치로 파싱
        }
    }
}
