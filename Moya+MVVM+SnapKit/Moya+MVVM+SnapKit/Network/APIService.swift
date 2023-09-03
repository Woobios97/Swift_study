//
//  APIService.swift
//  Moya+MVVM+SnapKit
//
//  Created by 김우섭 on 2023/09/03.
//

/*
 - GitHubService :  Moya Target을 정의하며, GitHub API 엔드포인트와 요청 방법을 정의합니다.
 - 'User' 구조체 :  API에서 반환되는 사용자 데이터를 파싱할 모델입니다.
 
 1. Moya Target 정의
 - Moya는 인터넷을 통해 데이터를 주고받는 도구와 같다. 이 도구를 사용하려면 어던 데이터를 어디서 가져올지 알려줘야한다. 그게 바로 여기에선 'GitHubService'이다.
 - 이 예제에서는 "GitHubService"는 인터넷에서 GitHub에 사용자 정보를 요청할 때 어떻게 요청해야 하는 지 알려주는 역할을 한다.
 - 예를들어, "GitHub, 사용자 목록을 가져와줘!"라고 부탁하면, "GitHubService"가 이 요청을 어떻게 하는 지 알려준다.
 
 2. Model 정의:
 - 모델은 데이터를 저장하기 위한 특별한 종류의 저장소와 같다. 이 저장소에는 데이터의 특정 부분을 담을 수 있다.
 - 예를 들어, 사용자 정보를 저장하려면 사용자 이름('login')과 아이디('id')를 저장해야한다. 그런 정보를 담기 위한 특별한 상자가 필요한데, 그게 바로 'User'이다.
 - 'User'는 사용자의 이름과 아이디를 저장할 때 사용하는 툴과 같다. 이런 정보를 어떻게 담을지 알려주는 설계도와 같다.
  */

/*
 1. baseURL(기본주소):
 - baseURL은 컴퓨터로부터 정보를 가져올 웹 서버의 주소와 같다. 여기서는 GitHub 서버 주소를 사용하낟. 즉, 정보를 어디서 가져올 지를 알려주는 주소이다.
 2. path(경로):
 - path는 서버 안에 특정 문서나 정보의 위치를 알려준다. 예를 들어, '/users'라고 하면 GitHub서버에서 사용자 정보를 가져오는 곳을 가리킵니다.
 3. method(요청 방법):
 - method는 정보를 가져올 때 사용하는 방법이다. 여기서는 '.get'을 사용하는데, 이건 정보를 가져오라는 뜻이다.
 4. task(작업):
 - task는 요청할 때 추가적으로 필요한 정보를 담아두는 곳이다. 이 예제에서는 '.requsetPlain'을 사용하는데, 이건 추가 정보 없이 단순히 정보를 가져오라고 하는 것이다.
 5. headers(헤더):
 - headers는 요청할 때 부가적인 정보를 담아두는 곳이다. 여기서는 특별한 정보를 넣지 않았으니 헤더는 비어있다.
 
 요약
 - baseURL는 정보를 가져올 서버주소, path는 그 서버에서 어떤 정보를 가져올지, method는 정보를 가져오는 방법, task는 필요한 정보,
 headers는 부가 정보를 나타낸다.
 */

import Moya
import Foundation

enum GitHubService {
    case getUsers
}

// Moya Target 정의
extension GitHubService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }

}

// 모델정의
struct User: Codable {
    let login: String
    let id: Int
}
