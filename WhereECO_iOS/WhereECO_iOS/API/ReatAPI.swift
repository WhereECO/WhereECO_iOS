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
            print("json 받아오기 확인1")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                print("json 받아오기 확인2")
                // get
                let decoder = JSONDecoder()
                print("json 받아오기 확인3")
                
                // decoder
                let json = try!decoder.decode([addressInfo].self, from: data)
                addressData = json
                closure(json)
                print("json 받아오기 확인4")
                
            }.resume()
            print("json 받아오기 확인5")
        }
    }
    
    
    // 회원가입 정보 보내고 성공 여부 리턴하기
    func postSignUp(name: String, id: String, pwd: String, checkpwd: String) {
        let comment = SignUpInfo(name: name, id: id, pwd: pwd, checkpwd: checkpwd)
        guard let uploadData = try? JSONEncoder().encode(comment)
        else {return}
        
        // URL 객체 정의
        let url = URL(string: "http://localhost:8088/auth/signup")
        
        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // HTTP 메시지 헤더
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            
            // 서버가 응답이 없거나 통신이 실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            print("comment post success")
        }
        // POST 전송
        task.resume()
    }
    
    // 로그인 성공 여부 리턴
    func postLogin(id: String, pwd: String) {
        let comment = LoginInfo(id: id, pwd: pwd)
        guard let uploadData = try? JSONEncoder().encode(comment)
        else {return}
        
        // URL 객체 정의
        let url = URL(string: "http://localhost:8088/auth/signin")
        
        // URLRequest 객체를 정의
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        // HTTP 메시지 헤더
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { (data, response, error) in
            
            // 서버가 응답이 없거나 통신이 실패
            if let e = error {
                NSLog("An error has occured: \(e.localizedDescription)")
                return
            }
            // 응답 처리 로직
            print("comment post success")
        }
        // POST 전송
        task.resume()
    }
}

