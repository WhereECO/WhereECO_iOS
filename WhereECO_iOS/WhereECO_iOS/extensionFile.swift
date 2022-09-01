//
//  extensionFile.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit

extension UIColor {
    class var darkBrown: UIColor? { return UIColor(named: "darkBrown")}
    class var lightBrown: UIColor? { return UIColor(named: "lightBrown")}
    class var mainGreen: UIColor? { return UIColor(named: "mainGreen")}
    class var mainYellow: UIColor? { return UIColor(named: "mainYellow")}
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        vc.navigationController!.navigationBar.barTintColor = UIColor.lightYellow
//        vc.navigationController!.navigationBar.isTranslucent = false
//        vc.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//    }
    
    @objc func loginBtnPressed(sender: UITapGestureRecognizer) {
        print("LoginView -> MapView")
        let mainVC = MapVC()
        navigationController?.pushViewController(mainVC, animated: true)
        mainVC.navigationController!.navigationBar.isTranslucent = false
        mainVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    @objc func signUpBtnPressed(sender: UITapGestureRecognizer) {
        print("LoginView -> SignUpView")
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
//        signUpVC.navigationController!.navigationBar.isTranslucent = false
//        signUpVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let id = mainIdTextField.text, !id.isEmpty else { return }
        guard let pwd = mainPwdTextField.text, !pwd.isEmpty else { return }
            
//        if userModel.isValidEmail(id: id){
//            if let removable = self.view.viewWithTag(100) {
//                removable.removeFromSuperview()
//            }
//        }
//        else {
//            shakeTextField(textField: mainIdTextField)
//            let idLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
//            idLabel.text = "아이디 형식을 확인해 주세요"
//            idLabel.textColor = UIColor.red
//            idLabel.tag = 100
//
//            self.view.addSubview(idLabel)
//        } // 이메일 형식 오류
//
//        if userModel.isValidPassword(pwd: pwd){
//            if let removable = self.view.viewWithTag(101) {
//                removable.removeFromSuperview()
//            }
//        }
//        else{
//            shakeTextField(textField: mainIdTextField)
//            let pwdLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
//            pwdLabel.text = "비밀번호 형식을 확인해 주세요"
//            pwdLabel.textColor = UIColor.red
//            pwdLabel.tag = 101
//
//            self.view.addSubview(pwdLabel)
//        } // 비밀번호 형식 오류
        
//        if (loginInfo.id == mainIdTextField.text) && (loginInfo.pwd == mainPwdTextField.text) {
//            let loginSuccess: Bool = loginCheck(id: loginInfo.id, pwd: loginInfo.pwd)
//            if loginSuccess {
//                print("로그인 성공")
//                if let removable = self.view.viewWithTag(102) {
//                    removable.removeFromSuperview()
//                }
//                self.performSegue(withIdentifier: "showMain", sender: self)
//            }
//            else {
//                print("로그인 실패")
//                shakeTextField(textField: mainIdTextField)
//                shakeTextField(textField: mainPwdTextField)
//                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
//                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
//                loginFailLabel.textColor = UIColor.red
//                loginFailLabel.tag = 102
//
//                self.view.addSubview(loginFailLabel)
//            }
//        }
    }
    
    // 로그인 확인하기
    @objc func loginCheck() {
        print("로그인 버튼 클릭")
        let nextView = MapVC()
        self.navigationController?.pushViewController(nextView, animated: true)
        
//        if (loginAPI(id: mainIdTextField.text ?? "id", pwd: mainPwdTextField.text ?? "pwd") == true) {
//            let mainVC = MainVC()
//            navigationController?.pushViewController(mainVC, animated: true)
//            mainVC.navigationController!.navigationBar.isTranslucent = false
//            mainVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//        } else {
//            print("로그인 실패")
//            shakeTextField(textField: mainIdTextField)
//            shakeTextField(textField: mainPwdTextField)
//
//            let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
//            loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
//            loginFailLabel.textColor = UIColor.red
//            loginFailLabel.tag = 102
//
//            self.view.addSubview(loginFailLabel)
//        }
    }
    
    // TextField 흔들기 애니메이션
    func shakeTextField(textField: UITextField) -> Void{
        UIView.animate(withDuration: 0.2, animations: {
            textField.frame.origin.x -= 10
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                textField.frame.origin.x += 20
             }, completion: { _ in
                 UIView.animate(withDuration: 0.2, animations: {
                    textField.frame.origin.x -= 10
                })
            })
        })
    }

    // 다음 누르면 입력창 넘어가기, 완료 누르면 키보드 내려가기
    @objc func didEndOnExit(_ sender: UITextField) {
        if mainIdTextField.isFirstResponder {
            mainPwdTextField.becomeFirstResponder()
        }
    }

}
