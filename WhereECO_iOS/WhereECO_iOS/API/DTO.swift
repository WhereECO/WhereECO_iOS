//
//  DTO.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import Foundation

struct UserInfo: Codable {
    /*
     id: 아이디
     pwd: 패스워드
     */
    
    init(userId: String = "", pwd: String = "", token:String = "") {
        self.userId = userId
        self.pwd = pwd
        self.token = token
    }
    
    var userId: String
    var pwd: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case pwd = "pwd"
        case token = "token"
    }
}

struct TokenInfo: Codable {
    init(grantType: String="", accessToken: String="") {
        self.grantType = grantType
        self.accessToken = accessToken
    }
    
    var grantType: String?
    var accessToken: String?
}


struct TodoInfo: Codable {
    init(todo1: Bool = false, todo2: Bool = false, todo3: Bool = false, url1: String="", url2: String="", url3: String="") {
        self.todo1 = todo1
        self.todo2 = todo2
        self.todo3 = todo3
        self.url1 = url1
        self.url2 = url2
        self.url3 = url3
    }

    var todo1: Bool?
    var todo2: Bool?
    var todo3: Bool?
    var url1: String?
    var url2: String?
    var url3: String?
}

struct SignUpInfo: Codable {
    /*
     name: 이름
     id: 아이디
     pwd: 패스워드
     checkpwd: 패스워드 확인
     */
    
    init(name: String = "", id: String = "", pwd: String = "", checkPwd: String = "") {
        self.name = name
        self.id = id
        self.pwd = pwd
        self.checkPwd = checkPwd
    }
    
    var name: String
    var id: String
    var pwd: String
    var checkPwd: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id, pwd, checkPwd
    }
}

struct addressInfo: Codable {
    /*
     id: 아이디
     latitude: 위도
     longitude: 경도
     addressName: 주소이름
     placeName: 장소이름
     */
    init(id: Int = 0, latitude: Double = 0.0, longitude: Double = 0.0, addressName: String = "", placeName: String = "") {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.addressName = addressName
        self.placeName = placeName
    }
    
    let id: Int
    let latitude: Double
    let longitude: Double
    let addressName: String
    let placeName: String
}

var addressData: [addressInfo] = []
var tokenData: [TokenInfo] = []
