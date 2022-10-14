//
//  MapVC.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit
import MapKit
import CoreLocation
import Security

class MapVC: UIViewController {
    
    let restApi = RestAPI()
    private var member = [addressInfo].init()    // address 관련 member
    private var loginMember = UserInfo()    // login 관련 member
    
    func update() {
        restApi.GET_Address(closure: { [self] datas in
            member = datas
            createMaker2()
        })
        for i in member {
            let userlocation = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
        }
    }
    
    var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainYellow
        return view
    }()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    
    // LinkPage 이동하기 위한 버튼
    lazy var linkPageBtn: UIButton = {
        let linkPageBtn = UIButton()
        linkPageBtn.addTarget(self, action: #selector(linkPageBtnPressed), for: .touchUpInside)
        linkPageBtn.setImage(UIImage.init(named: "leafImage"), for: .normal)
        return linkPageBtn
    }()
    
    // 검색 창
    lazy var searchTextField: UITextField = {
        let searchLocation = UITextField()
        searchLocation.textColor = .darkBrown
        searchLocation.backgroundColor = .mainYellow
        searchLocation.placeholder = "제로 웨이스트 샵 검색"
        searchLocation.layer.cornerRadius = 5
        searchLocation.borderStyle = .roundedRect
        searchLocation.clearButtonMode = .whileEditing   // 입력하기 위해서 clear한 btn상태
        return searchLocation
    }()
    
    // 검색하기 버튼
    lazy var searchBtn: UIButton = {
        let searchBtn = UIButton()
        searchBtn.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        searchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .darkBrown
        searchBtn.backgroundColor = .mainYellow
        searchBtn.layer.cornerRadius = 5
        return searchBtn
    }()
    
    // 지도 view
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light // lignt mode
        return map
    }()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()     // startUpdate를 해야 didUpdateLocation 메서드가 호출된다.
        manager.delegate = self
        return manager
    }()
    
    // 현위치로 돌아가는 버튼을 생성한다.
    lazy var locationBtn: UIButton = {
        let btn1 = UIButton()                    // 버튼 생성하기 위한 변수 생성
        btn1.setTitle("내 위치로 이동하기", for: .normal)
        btn1.backgroundColor = .mainYellow       // 버튼 색상
        btn1.setTitleColor(.darkBrown, for: .normal) // 버튼 글씨 색상
        btn1.layer.cornerRadius = 10
        btn1.tintColor = .mainYellow
        btn1.addTarget(self, action: #selector(goUserPosition), for: .touchUpInside)   // 버튼이 경계 안에서 터치 됐을때 buttonAction이 작동한다.
        return btn1
    }()
    
    // buttonAction을 설정하기 위한 함수
    @objc func goUserPosition(sender: UIButton!) {
        print("현재 위치로 이동")           // 작동되는지 확인하기 위한 print문
        // 설정한 위치로 이동한다.
        self.mapView.setUserTrackingMode(.follow, animated: true)   // 위치에 따라 화면이 바뀐다.
        //        DispatchQueue.main.async - 지금은 비동기를 해 줄 필요가 없다.
    }
    
    // 위치를 나타낼 함수
    func createMarker(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        let marker = Marker(title: title, subtitle: subtitle, coordinate: coordinate)
        mapView.addAnnotation(marker)
    }
    
    // 핀을 찍는 함수
    func createMaker2() {
        for i in member {
            createMarker(title: i.placeName, subtitle: i.addressName, coordinate: CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude))
            print("member 정보", i.placeName)
        }
    }
    
    // 클릭 재스처를 추가하기 위한 함수
    func addGesture() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(didClickMapView(sender:)))
        self.mapView.addGestureRecognizer(touch)
    }
    
    // 핀 생성 버튼
    lazy var createMarkerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createMarkerAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLocationUsagePermission()        // 권한을 요청하기 위한 창
        self.mapView.showsUserLocation = true   // 사용자 위치를 나타낸 것을 보여준다.
        
        label.text = "찾아봐요!"
        label.textColor = .darkBrown
        
        self.view.backgroundColor = .mainGreen
        
        self.view.addSubview(titleView)
        self.view.addSubview(label)
        self.view.addSubview(linkPageBtn)
        self.view.addSubview(searchTextField)
        self.view.addSubview(searchBtn)
        self.view.addSubview(mapView)
        self.mapView.addSubview(locationBtn)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 100)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
        linkPageBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkPageBtn.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            linkPageBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            linkPageBtn.heightAnchor.constraint(equalToConstant: 20),
            linkPageBtn.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            searchTextField.widthAnchor.constraint(equalToConstant: 330)
        ])
        
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            searchBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            searchBtn.heightAnchor.constraint(equalToConstant: 30),
            searchBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 20),
            mapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 620),
            mapView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        locationBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationBtn.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor),
            locationBtn.centerYAnchor.constraint(equalTo: self.mapView.centerYAnchor, constant: -285),
            locationBtn.heightAnchor.constraint(equalToConstant: 25),
            locationBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        update()
        addGesture()
        
    }
    
    //MARK: 해당 계정으로 패스워드를 키체인에서 가져오기
    func readItemsOnKeyChain() {
        let account = loginMember.id
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrAccount: account,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess {
            print("read failed")
            return
        }
        guard let existingItem = item as? [String: Any] else { return }
        guard let data = existingItem["v_Data"] as? Data else { return }
        guard let token = String(data: data, encoding: .utf8) else { return }
        
        print(token)
    }
    
}

// MARK: - extension MapViewController
extension MapVC: UITableViewDelegate, CLLocationManagerDelegate {
    @objc func linkPageBtnPressed() {
        readItemsOnKeyChain()
        
        //        restApi.POST_Token -> 토큰 post하기
        print("keyChain에서 가져오기 성공!")
        let vc = LinkVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBtnPressed() {
        print("함수 실행1")
        let place = searchTextField.text
        for i in member {
            if place == i.placeName {
                goLocation(latitude: i.latitude, longitude: i.longitude, delta: 0.01)
                print(i.placeName)
                print("함수 실행2")
            }
        }
    }
    
    
    // 위도, 경도에 따른 주소 찾기
    func goLocation(latitude latitudeValue: CLLocationDegrees, longitude longitudeValue : CLLocationDegrees, delta span :Double) {
        print("...함수 실행...")
        
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        mapView.setRegion(pRegion, animated: true)
    }
    
    // 권한을 요청하는 함수
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()    // 권한을 요청하는 것
    }
    
    // 흰색 뷰를 보이게
    @objc func createMarkerAction() {
        print("흰색 popView")
        
    }
    
    @objc func didClickMapView(sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: self.mapView)
        let mapLocation: CLLocationCoordinate2D = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        print("위도 : \(mapLocation.latitude), 경도 : \(mapLocation.longitude)")
        
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
