//
//  ViewController.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/08/31.
//

import UIKit

class ViewController: UIViewController {
    
    // Where ECO
    lazy var mainText: UILabel = {
        let mainText = UILabel()
        mainText.textColor = .darkBrown
        mainText.backgroundColor = .mainGreen
        mainText.font = UIFont(name: "NotoSansKR-Bold", size: 20)
        mainText.font = UIFont.systemFont(ofSize: 30)
        mainText.text = "Where ECO?"
        mainText.sizeToFit()
        return mainText
    }()
    
    // 아이디 입력창
    lazy var mainIdTextField: UITextField = {
        let mainidText = UITextField()
        mainidText.textColor = .darkBrown
        mainidText.backgroundColor = .white
        mainidText.placeholder = "아이디"
        mainidText.layer.cornerRadius = 5
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
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.mainText)
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
        

        mainText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250),
            mainText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
        mainIdTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainIdTextField.topAnchor.constraint(equalTo: mainText.topAnchor, constant: 250),
            mainIdTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            mainIdTextField.widthAnchor.constraint(equalToConstant: 350),
            mainIdTextField.heightAnchor.constraint(equalToConstant: 50),
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


}

