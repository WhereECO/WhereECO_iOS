//
//  extensionFile.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit
import MapKit

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

// MARK: extension MapViewController
extension MapVC: UITableViewDelegate, CLLocationManagerDelegate { 
    @objc func linkPageBtnPressed() {
        let vc = LinkVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 권한을 요청하는 함수
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()    // 권한을 요청하는 것
    }
    
    @objc func didClickMapView(sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: self.mapView)
        let mapLocation: CLLocationCoordinate2D = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        print("위도 : \(mapLocation.latitude), 경도 : \(mapLocation.longitude)")
        
    }
    
    // 클릭 재스처를 추가하기 위한 함수
    func addGesture() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(didClickMapView(sender:)))
        self.mapView.addGestureRecognizer(touch)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:   // 권한 동의를 누른 상태
            print("GPS 권한 설정됨.")
            DispatchQueue.main.async {
                self.mapView.setUserTrackingMode(.follow, animated: true)   // 위치에 따라 화면이 바뀐다.
            }
        case .restricted, .notDetermined:               // 권한 동의 버튼 자체를 누르지 않은 상태
            print("GPS 권한 설정되지 않음.")
            DispatchQueue.main.async {                  // 권한 요청을 비동기로 보냄. (팝업으로 띄워야되기 때문이다. 만약 비동기를 사용하지 않으면 권한 설정이 될 때까지 작동하지 않음.)
                self.getLocationUsagePermission()
            }
        case .denied:                                   // 권한 거부를 누른 상태
            print("GPS 권한 요청 거부됨.")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        default:
            print("GPS: Default")
        }
    }
}

// MARK: extension LinkViewController
extension LinkVC: UITableViewDelegate, UITableViewDataSource {
    
    @objc func backAction(sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logOutAction(sender: UITapGestureRecognizer) {
//        let vc = ViewController()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as UITableViewCell
        cell.textLabel?.text = items[indexPath.row]
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 5
        cell.backgroundColor = .mainYellow
        cell.textLabel?.textColor = .darkBrown
        let selectedColor = UIView()
        selectedColor.backgroundColor = .mainGreen
        cell.selectedBackgroundView = selectedColor
        return cell
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
