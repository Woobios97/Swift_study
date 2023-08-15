//
//  StationResponseModel.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/13.
//

import Foundation

// StationResponseModel().searchInfo.row -> 실제로 사용하려고 할 때
// StationResponseModel.stations


struct StationResponseModel: Decodable {
    var stations: [Station] { searchInfo.row }
    
    private let searchInfo: SearchInfoBySubwayNameServiceModel
    
    enum CodingKeys: String, CodingKey {
        case searchInfo = "SearchInfoBySubwayNameService"
    }
    
    struct SearchInfoBySubwayNameServiceModel: Decodable {
        var row: [Station] = []
    }
}

struct Station: Decodable {
    let stationName: String
    let lineNumber: String
    
    enum CodingKeys: String, CodingKey {
        case stationName = "STATION_NM"
        case lineNumber = "LINE_NUM"
    }
}
