//
//  MapVC.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainYellow
        return view
    }()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    
    lazy var linkPageBtn: UIButton = {
        let linkPageBtn = UIButton()
        // LinkPage 이동하기 위한 버튼
        linkPageBtn.addTarget(self, action: #selector(linkPageBtnPressed), for: .touchUpInside)
        linkPageBtn.setImage(UIImage.init(named: "leafImage"), for: .normal)
        return linkPageBtn
    }()
    
    lazy var searchTextField: UITextField = {
        let searchLocation = UITextField()
        searchLocation.textColor = .darkBrown
        searchLocation.backgroundColor = .mainYellow
        searchLocation.placeholder = "제로 웨이스트 샵 검색"
        searchLocation.layer.cornerRadius = 5
        //        searchLocation.layer.borderWidth = 1
        //        searchLocation.layer.borderColor = UIColor.darkGreen?.cgColor
        searchLocation.borderStyle = .roundedRect
        searchLocation.clearButtonMode = .whileEditing   // 입력하기 위해서 clear한 btn상태
        return searchLocation
    }()
    
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

    lazy var retryBtn: UIButton = {
        let retryBtn = UIButton()        // LinkPage 이동하기 위한 버튼
        retryBtn.setTitle("현재 지도에서 찾기", for: .normal)
        retryBtn.backgroundColor = .mainYellow       // 버튼 색상
        retryBtn.setTitleColor(.darkBrown, for: .normal) // 버튼 글씨 색상
        retryBtn.layer.cornerRadius = 10
        retryBtn.tintColor = .mainYellow
        retryBtn.addTarget(self, action: #selector(linkPageBtnPressed), for: .touchUpInside)
        return retryBtn
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
        self.view.addSubview(mapView)
        self.mapView.addSubview(retryBtn)
        
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
            searchTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: 30),
            searchTextField.widthAnchor.constraint(equalToConstant: 330)
        ])
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: 20),
            mapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 620),
            mapView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        retryBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            retryBtn.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor),
            retryBtn.centerYAnchor.constraint(equalTo: self.mapView.centerYAnchor, constant: -285),
            retryBtn.heightAnchor.constraint(equalToConstant: 25),
            retryBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
        
    }

}

