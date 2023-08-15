//
//  StationDetailCollectionViewCell.swift
//  SubwayStation
//
//  Created by 김우섭 on 2023/08/12.
//

import SnapKit
import UIKit

// 실시간 도착 정보를 표시하는 컬렉션 뷰 셀 클래스
final class StationDetailCollectionViewCell: UICollectionViewCell {
    
    // 열차 노선 정보를 표시할 레이블
    private lazy var lineLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()
    
    // 남은 도착 시간을 표시할 레이블
    private lazy var remainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    // 셀의 뷰와 정보 설정 메서드
    func setUP(with realTimeArrival: StationArrivalDatResponseModel.RealTimeArrival) {
        layer.cornerRadius = 12.0 // 셀 레이아웃을 둥글게 표현하기 위해 레이어의 코너 반지름 설정
             layer.shadowColor = UIColor.black.cgColor // 그림자의 색상 설정
             layer.shadowOpacity = 0.2 // 그림자의 투명도 설정
             layer.shadowRadius = 10 // 그림자의 반경 설정
        
        backgroundColor = .systemBackground // 배경색을 시스템 기본 배경 색으로 설정
        
        // 레이블들을 셀에 추가
        [lineLabel, remainTimeLabel].forEach {addSubview($0)}
        
        // 레이블 위치 설정
        lineLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0) // 왼쪽 여백 16.0
            $0.top.equalToSuperview().inset(16.0) // 위쪽 여백 16.0
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineLabel) // 노선 레이블과 같은 위치
            $0.top.equalTo(lineLabel.snp.bottom).offset(16.0) // 노선 레이블 아래로 16.0 만큼 내려옴
            $0.bottom.equalToSuperview().inset(16.0) // 아래쪽 여백 16.0
        }
        
        lineLabel.text = realTimeArrival.line // 노선 정보 설정
        remainTimeLabel.text = realTimeArrival.remainTime // 남은 도착 시간 정보 설정
    }
}
