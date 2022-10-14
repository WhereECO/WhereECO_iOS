//
//  extensionFile.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit
import MapKit
import CoreLocation
import YoutubePlayer_in_WKWebView

// MARK: extension UIColor
extension UIColor {
    class var darkBrown: UIColor? { return UIColor(named: "darkBrown")}
    class var lightBrown: UIColor? { return UIColor(named: "lightBrown")}
    class var mainGreen: UIColor? { return UIColor(named: "mainGreen")}
    class var mainYellow: UIColor? { return UIColor(named: "mainYellow")}
}

// MARK: extension ViewController
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
        signUpVC.navigationController!.navigationBar.isTranslucent = false
        signUpVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    // 로그인 확인하기
    @objc func loginCheck() {
        print("로그인 버튼 클릭")
        let mainVC = MapVC()
        navigationController?.pushViewController(mainVC, animated: true)
        mainVC.navigationController!.navigationBar.isTranslucent = false
        mainVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let id = mainIdTextField.text, !id.isEmpty else { return }
        guard let pwd = mainPwdTextField.text, !pwd.isEmpty else { return }

        if (loginMember.id == mainIdTextField.text) && (loginMember.pwd == mainPwdTextField.text) {
            print("로그인 성공")
            do {
                try addItemsOnKeyChain()
                print("keyChain에 저장 성공!")
                let mainVC = MapVC()
                navigationController?.pushViewController(mainVC, animated: true)
                mainVC.navigationController!.navigationBar.isTranslucent = false
                mainVC.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            } catch {
                print("keyChain에 저장하지 못함.")
            }

        } else {
            print("로그인 실패")
            shakeTextField(textField: mainIdTextField)
            shakeTextField(textField: mainPwdTextField)
        }


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

// MARK: extension SignUpViewController
extension SignUpVC: UITableViewDelegate {
    func setupTextFields() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, idTextField, pwdTextField, checkPwdTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        if nameTextField.isFirstResponder {
            idTextField.becomeFirstResponder()
        }
        else if idTextField.isFirstResponder {
            pwdTextField.becomeFirstResponder()
        }
        else if pwdTextField.isFirstResponder {
            checkPwdTextField.becomeFirstResponder()
        }
    }
    
    @objc func backBtnAction() {
        print("로그인 화면으로 돌아가기!")
        navigationController?.popViewController(animated: true)
    }
    // 서버로 저장한 내용 보내기!
    @objc func saveAction() {
        print("저장하기!")
        // 저장하기 Action
        validateForm()
//        restApi.POST_SignUp(name: nameTextField.text, id: idTextField.text, pwd: pwdTextField.text, checkPwd: checkPwdTextField.text)
        navigationController?.popViewController(animated: true)
    }
    
    func validateForm() {
        guard let nameText = nameTextField.text, !nameText.isEmpty else { return }
        guard let idText = idTextField.text, !idText.isEmpty else { return }
        guard let pwdText = pwdTextField.text, !pwdText.isEmpty else { return }
        guard let checkPwdText = checkPwdTextField.text, !checkPwdText.isEmpty else { return }
        
        startSigningUp(name: nameText, id: idText, pwd: pwdText)
    }
    
    func startSigningUp(name: String, id: String, pwd: String) {
        print("Please call any Sign up api for registration: ", name, id, pwd)
    }
}

// MARK: extension LinkViewController
extension LinkVC: UITableViewDelegate {
    
    @objc func backAction(sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logOutAction(sender: UITapGestureRecognizer) {
        // 값을 없애는 작업 필요
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func checkAction1(sender: UITapGestureRecognizer) {
        checkBtn1.tintColor = .red
    }
    
    @objc func checkAction2(sender: UITapGestureRecognizer) {
        checkBtn2.tintColor = .red
    }
    
    @objc func checkAction3(sender: UITapGestureRecognizer) {
        checkBtn3.tintColor = .red
    }
}

extension LinkVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: youtubeCell.id, for: indexPath)
        if let cell = cell as? youtubeCell {
            
            let youtubeView = WKYTPlayerView()
            cell.addSubview(youtubeView)
            youtubeView.snp.makeConstraints {
                $0.leading.trailing.top.bottom.equalTo(0)
            }
            cell.youtubeViewDidBecomeReady(youtubeView, id: dataSource[indexPath.row])
        }
        
        return cell
    }
}

extension LinkVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: collectionView.frame.height) // point
    }
}

//MARK: PaddingLabel
class PaddingLabel: UILabel {
    
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }
}
