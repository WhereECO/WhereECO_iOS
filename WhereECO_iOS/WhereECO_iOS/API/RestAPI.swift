//
//  ReatAPI.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/02.
//

import Foundation

class RestAPI {
    let sync_que = DispatchQueue.global()
    let sync_group = DispatchGroup.init()
    
    // 실시간 지도 정보 가져오기
    func GET_Address(closure: @escaping ([addressInfo]) -> Void) {
        
        if let url = URL(string: "http://localhost:8088/addresses") {
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                // get
                let decoder = JSONDecoder()
                
                // decoder
                let json = try!decoder.decode([addressInfo].self, from: data)
                addressData = json
                closure(json)
                
            }.resume()
        }
    }
    
    
    // 회원가입 정보 보내고 성공 여부 리턴하기
    func POST_SignUp(name: String, id: String, pwd: String, checkPwd: String) {
        let comment = SignUpInfo(name: name, id: id, pwd: pwd, checkPwd: checkPwd)
        guard let uploadData = try? JSONEncoder().encode(comment)
        else {return}
        
        // URL 객체 정의
        let url = URL(string: "http://localhost:8088/users/join")
        
        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = uploadData

        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // 서버가 응답이 없거나 통신이 실패
                print(error?.localizedDescription ?? "No data")
                return
            }
            // 응답 처리 로직
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    // 로그인 정보 받아오기
    func GET_SignUp(closure: @escaping (SignUpInfo) -> Void) {
        
        if let url = URL(string: "http://localhost:8088/users/join") {
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                // get
                let decoder = JSONDecoder()
                
                // decoder
                let json = try!decoder.decode(SignUpInfo.self, from: data)
                closure(json)
                
            }.resume()
        }
    }
    
    // 로그인 정보 보내기
    func POST_Login(id: String, pwd: String) {
        let comment = UserInfo(id: id, pwd: pwd)
        guard let uploadData = try? JSONEncoder().encode(comment)
        else {return}
        
        // URL 객체 정의
        let url = URL(string: "http://localhost:8088/users/login")
        
        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = uploadData

        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // 서버가 응답이 없거나 통신이 실패
                print(error?.localizedDescription ?? "No data")
                return
            }
            // 응답 처리 로직
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    // 로그인 정보 받아오기
    func GET_Login(closure: @escaping (UserInfo) -> Void) {
        
        if let url = URL(string: "http://localhost:8088/users/login") {
            var request = URLRequest.init(url: url)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                // get
                let decoder = JSONDecoder()
                
                // decoder
                let json = try!decoder.decode(UserInfo.self, from: data)
                closure(json)
                
            }.resume()
        }
    }
}

