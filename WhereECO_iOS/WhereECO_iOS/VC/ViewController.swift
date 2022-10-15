//
//  ViewController.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/08/31.
//

import UIKit
import Security

enum KeychainError: Error {
    case unexpectedPasswordStatus
    case duplicatePasswordKeyValue
}

class ViewController: UIViewController {
    
    let restApi = RestAPI()
    var loginMember = UserInfo()    // login 관련 member
    
    lazy var logoimage: UIImageView = {
        let logoimage = UIImageView()
        logoimage.image = UIImage(named:"Logo")
        return logoimage
    }()
    
    // 아이디 입력창
    lazy var mainIdTextField: UITextField = {
        let mainidText = UITextField()
        mainidText.textColor = .darkBrown
        mainidText.backgroundColor = .white
        mainidText.placeholder = "아이디"
        mainidText.layer.cornerRadius = 5
//        mainidText.font = UIFont(name: "NanumGothic", size: 10)
//        mainidText.layer.borderWidth = 1
//        mainidText.layer.borderColor = UIColor.darkBrown?.cgColor
        mainidText.borderStyle = .roundedRect
        mainidText.clearButtonMode = .whileEditing   // 입력하기 위해서 clear한 btn상태
        return mainidText
    }()
    
    // 비밀번호 입력창
    lazy var mainPwdTextField: UITextField = {
        let mainpwdText = UITextField()
        mainpwdText.textColor = .darkBrown
        mainpwdText.backgroundColor = .white
        mainpwdText.placeholder = "비밀번호"
        mainpwdText.layer.cornerRadius = 5
        mainpwdText.isSecureTextEntry = true
//        mainpwdText.layer.borderWidth = 1
//        mainpwdText.layer.borderColor = UIColor.darkBrown?.cgColor
        mainpwdText.borderStyle = .roundedRect
        mainpwdText.clearButtonMode = .whileEditing   // 입력하기 위해서 clear한 btn상태
        return mainpwdText
    }()
    
    // 회원가입 버튼
    lazy var signUpBtn: UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitle("회원가입", for: .normal)     // 버튼에 들어갈 글씨
        signUpButton.backgroundColor = .mainYellow      // 버튼 색상
        signUpButton.setTitleColor(.darkBrown, for: .normal) // 버튼 글씨 색상
        signUpButton.layer.cornerRadius = 5
//        signUpButton.layer.borderWidth = 1
//        signUpButton.layer.borderColor = UIColor.darkBrown?.cgColor
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()
    
    // 로그인 버튼
    lazy var loginBtn: UIButton! = {
        let loginButton = UIButton()
        loginButton.setTitle("로그인", for: .normal)     // 버튼에 들어갈 글씨
        loginButton.backgroundColor = .mainYellow       // 버튼 색상
        loginButton.setTitleColor(.darkBrown, for: .normal) // 버튼 글씨 색상
        loginButton.layer.cornerRadius = 5
//        loginButton.layer.borderWidth = 1
//        loginButton.layer.borderColor = UIColor.darkBrown?.cgColor
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.mainText)
        self.view.addSubview(logoimage)
        self.view.addSubview(mainIdTextField)
        self.view.addSubview(mainPwdTextField)
        self.view.addSubview(signUpBtn)
        self.view.addSubview(loginBtn)
        
        self.view.backgroundColor = UIColor.mainGreen
        print("Where ECO?")
        
        self.navigationController!.isNavigationBarHidden = true
        self.view?.safeAreaLayoutGuide.owningView?.backgroundColor = .mainGreen
        

        // 키보드 내리기
        mainIdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        mainPwdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        loginBtn.addTarget(self, action: #selector(loginCheck), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnPressed), for: .touchUpInside)
        
        logoimage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoimage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            logoimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            logoimage.widthAnchor.constraint(equalToConstant: 300),
            logoimage.heightAnchor.constraint(equalToConstant: 300)
        ])
        mainIdTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainIdTextField.topAnchor.constraint(equalTo: logoimage.bottomAnchor, constant: 100),
            mainIdTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            mainIdTextField.widthAnchor.constraint(equalToConstant: 350),
            mainIdTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        mainPwdTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainPwdTextField.topAnchor.constraint(equalTo: mainIdTextField.topAnchor, constant: 80),
            mainPwdTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            mainPwdTextField.widthAnchor.constraint(equalToConstant: 350),
            mainPwdTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpBtn.topAnchor.constraint(equalTo: mainPwdTextField.topAnchor, constant: 100),
            signUpBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80),
            signUpBtn.widthAnchor.constraint(equalToConstant: 100),
            signUpBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginBtn.topAnchor.constraint(equalTo: mainPwdTextField.topAnchor, constant: 100),
            loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80),
            loginBtn.widthAnchor.constraint(equalToConstant: 100),
            loginBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    //MARK: 키체인에 넣을 아이템 생성
    func addItemsOnKeyChain() throws {
        //간단하게 네임이 younsu이고, 패스워드가 ask123인 유저의 패스워드를 keychain 형식으로 저장.
        let credentials = UserInfo(userId: loginMember.userId, pwd: loginMember.pwd, token: loginMember.token)
        let account = credentials.userId
        let token = credentials.token.data(using: String.Encoding.utf8)!
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: account,
                                    kSecValueData: token]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("success")
        } else if status == errSecDuplicateItem {
            updateItemOnKeyChain(value: token, key: account)
        } else {
            print("add failed")
            throw KeychainError.unexpectedPasswordStatus
        }
    }
    
    //MARK: 같은 키값이면 업데이트하기
    func updateItemOnKeyChain(value: Any, key: Any) {
        let previousQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                              kSecAttrAccount: key]
        let updateQuery: [CFString: Any] = [kSecValueData: value]
        
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        if status == errSecSuccess {
            print("update complete")
        } else {
            print("not finished update")
        }
    }
    
    //MARK: 해당 string으로 이루어진 키데이터 쌍 삭제하기
    func deleteItemOnKeyChain(key: String) {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                            kSecAttrAccount: key]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess {
            print("remove key-data complete")
        } else {
            print("remove key-data failed")
        }
    }
}

