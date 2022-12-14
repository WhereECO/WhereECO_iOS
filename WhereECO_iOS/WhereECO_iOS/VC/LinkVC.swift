//
//  LinkVC.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/01.
//

import UIKit
import SnapKit
import YoutubePlayer_in_WKWebView

class LinkVC: UIViewController {
    
    let restApi = RestAPI()
    var tokenMember = TokenInfo()
    var todoMember = TodoInfo()    // todo 관련 member
    
    
    var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainYellow
        return view
    }()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton()
        backBtn.setImage(UIImage.init(systemName: "leaf"), for: .normal)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backBtn.tintColor = .darkBrown
        return backBtn
    }()
    
    lazy var logOutBtn: UIButton = {
        let logOutBtn = UIButton()
        // 로그아웃 버튼
        logOutBtn.setImage(UIImage.init(systemName: "person.crop.circle.badge.xmark"), for: .normal)
        logOutBtn.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        logOutBtn.tintColor = .darkBrown
        return logOutBtn
    }()
    
    var toDoLabel: UILabel = {
        let todoText = UILabel()
        todoText.text = "오늘의 실천해요!"
        todoText.textColor = .darkBrown
        return todoText
    }()
    
    var toDoLabel1: PaddingLabel = {
        let todo1 = PaddingLabel()
        todo1.text = "텀블러는 챙겼나요?"
        todo1.textColor = .darkBrown
        todo1.backgroundColor = .mainYellow
        todo1.clipsToBounds = true
        todo1.layer.cornerRadius = 5
        todo1.layer.borderColor = UIColor.darkBrown?.cgColor
        todo1.layer.borderWidth = 1
        return todo1
    }()
    
    lazy var checkBtn1: UIButton = {
        let checkBtn = UIButton()
        checkBtn.layer.cornerRadius = (20)
        checkBtn.setImage(UIImage.init(systemName: "checkmark.circle"), for: .normal)
        checkBtn.tintColor = .mainYellow
        checkBtn.addTarget(self, action: #selector(checkAction1), for: .touchUpInside)
        return checkBtn
    }()
    
    var toDoLabel2: PaddingLabel = {
        let todo2 = PaddingLabel()
        todo2.text = "분리수거를 해요!"
        todo2.textColor = .darkBrown
        todo2.backgroundColor = .mainYellow
        todo2.clipsToBounds = true
        todo2.layer.cornerRadius = 5
        todo2.layer.borderColor = UIColor.darkBrown?.cgColor
        todo2.layer.borderWidth = 1
        return todo2
    }()
    
    lazy var checkBtn2: UIButton = {
        let checkBtn = UIButton()
        checkBtn.layer.cornerRadius = (20)
        checkBtn.setImage(UIImage.init(systemName: "checkmark.circle"), for: .normal)
        checkBtn.tintColor = .mainYellow
        checkBtn.addTarget(self, action: #selector(checkAction2), for: .touchUpInside)
        return checkBtn
    }()
    
    var toDoLabel3: PaddingLabel = {
        let todo3 = PaddingLabel()
        todo3.text = "대중교통을 이용해요!"
        todo3.textColor = .darkBrown
        todo3.backgroundColor = .mainYellow
        todo3.clipsToBounds = true
        todo3.layer.cornerRadius = 5
        todo3.layer.borderColor = UIColor.darkBrown?.cgColor
        todo3.layer.borderWidth = 1
        return todo3
    }()
    
    lazy var checkBtn3: UIButton = {
        let checkBtn = UIButton()
        checkBtn.layer.cornerRadius = (20)
        checkBtn.setImage(UIImage.init(systemName: "checkmark.circle"), for: .normal)
        checkBtn.tintColor = .mainYellow
        checkBtn.addTarget(self, action: #selector(checkAction3), for: .touchUpInside)
        return checkBtn
    }()
    
    var plusUrlLabel: UILabel = {
        let plusUrlText = UILabel()
        plusUrlText.text = "더 찾아봐요!"
        plusUrlText.textColor = .darkBrown
        return plusUrlText
    }()
    
    var dataSource: [String] = []
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 50 // cell사이의 간격 설정
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .mainYellow
        return view
    }()
    
    // Youtube Player Variable
    let playVarsDic = ["playsinline": 1]
    lazy var youtubeView: WKYTPlayerView = {
        let youtubeView = WKYTPlayerView()
        
        return youtubeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "실천해요!"
        label.textColor = .darkBrown
        
        self.view.backgroundColor = .mainGreen
        
        self.view.addSubview(titleView)
        self.view.addSubview(backBtn)
        self.view.addSubview(label)
        self.view.addSubview(logOutBtn)
        self.view.addSubview(toDoLabel)
        self.view.addSubview(toDoLabel1)
        self.view.addSubview(checkBtn1)
        self.view.addSubview(toDoLabel2)
        self.view.addSubview(checkBtn2)
        self.view.addSubview(toDoLabel3)
        self.view.addSubview(checkBtn3)
        self.view.addSubview(plusUrlLabel)
        self.view.addSubview(collectionView)
        
        setupDataSource()
        setupDelegate()
        registerCell()
        configure()
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 100)
        ])
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backBtn.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            backBtn.heightAnchor.constraint(equalToConstant: 50),
            backBtn.widthAnchor.constraint(equalToConstant: 50)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutBtn.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            logOutBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            logOutBtn.heightAnchor.constraint(equalToConstant: 40),
            logOutBtn.widthAnchor.constraint(equalToConstant: 40)
        ])
        toDoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoLabel.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 40),
            toDoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        toDoLabel1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoLabel1.topAnchor.constraint(equalTo: self.toDoLabel.bottomAnchor, constant: 30),
            toDoLabel1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30),
            toDoLabel1.heightAnchor.constraint(equalToConstant: 40),
            toDoLabel1.widthAnchor.constraint(equalToConstant: 300)
        ])
        checkBtn1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBtn1.topAnchor.constraint(equalTo: self.toDoLabel.bottomAnchor, constant: 30),
            checkBtn1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150),
            checkBtn1.heightAnchor.constraint(equalToConstant: 40),
            checkBtn1.widthAnchor.constraint(equalToConstant: 40)
        ])
        toDoLabel2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoLabel2.topAnchor.constraint(equalTo: self.toDoLabel1.bottomAnchor, constant: 30),
            toDoLabel2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30),
            toDoLabel2.heightAnchor.constraint(equalToConstant: 40),
            toDoLabel2.widthAnchor.constraint(equalToConstant: 300)
            
        ])
        checkBtn2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBtn2.topAnchor.constraint(equalTo: self.toDoLabel1.bottomAnchor, constant: 30),
            checkBtn2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150),
            checkBtn2.heightAnchor.constraint(equalToConstant: 40),
            checkBtn2.widthAnchor.constraint(equalToConstant: 40)
        ])
        toDoLabel3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoLabel3.topAnchor.constraint(equalTo: self.toDoLabel2.bottomAnchor, constant: 30),
            toDoLabel3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30),
            toDoLabel3.heightAnchor.constraint(equalToConstant: 40),
            toDoLabel3.widthAnchor.constraint(equalToConstant: 300)
        ])
        checkBtn3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBtn3.topAnchor.constraint(equalTo: self.toDoLabel2.bottomAnchor, constant: 30),
            checkBtn3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 150),
            checkBtn3.heightAnchor.constraint(equalToConstant: 40),
            checkBtn3.widthAnchor.constraint(equalToConstant: 40)
        ])
        plusUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusUrlLabel.topAnchor.constraint(equalTo: self.toDoLabel3.bottomAnchor, constant: 65),
            plusUrlLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            
        ])
        
    }
    
    private func setupDataSource() {
        dataSource.append("0JiF52gYbrw")
        dataSource.append("3hJ_p3xnpbw")
        dataSource.append("6r6xHflS7HA")
    }
    
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCell() {
        collectionView.register(youtubeCell.self, forCellWithReuseIdentifier: youtubeCell.id)
    }
    
    private func configure() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(500)
            make.height.equalTo(300)
        }
    }
    
}
