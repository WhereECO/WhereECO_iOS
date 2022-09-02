//
//  DTO.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import Foundation

struct LoginInfo: Codable {
    /*
     id: 아이디
     pwd: 패스워드
     */
    
    init(id: String = "", pwd: String = "") {
        self.id = id
        self.pwd = pwd
    }
    
    var id: String
    var pwd: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case pwd
    }
}

struct SignUpInfo: Codable {
    /*
     name: 이름
     id: 아이디
     pwd: 패스워드
     checkpwd: 패스워드 확인
     */
    
    init(name: String = "", id: String = "", pwd: String = "", checkpwd: String = "") {
        self.name = name
        self.id = id
        self.pwd = pwd
        self.checkpwd = checkpwd
    }
    
    var name: String
    var id: String
    var pwd: String
    var checkpwd: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id, pwd, checkpwd
    }
}
