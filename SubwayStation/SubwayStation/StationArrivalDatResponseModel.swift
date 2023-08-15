//
//  StationArrivalDatResponseModel.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/13.
//

import Foundation

struct StationArrivalDatResponseModel: Decodable {
    var realtimeArrivalList: [RealTimeArrival]
    
    struct RealTimeArrival: Decodable {
        let line: String // ~행
        let remainTime: String // 도착까지 남은 시간 of 전역 출발
        let currentStation: String // 현재위치
        
        enum CodingKeys: String, CodingKey {
            case line = "trainLineNM"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}
