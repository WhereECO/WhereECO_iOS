//
//  youtubeCell.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/12.
//

import UIKit
import SnapKit
import YoutubePlayer_in_WKWebView

class youtubeCell: UICollectionViewCell {
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: String? { didSet { bind() } }

//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//
//        return label
//    }()
    
    // Youtube Player Variable
    let playVarsDic = ["playsinline": 1]
    lazy var youtubeView: WKYTPlayerView = {
        let youtubeView = WKYTPlayerView()
        
        return youtubeView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
        youtubeViewDidBecomeReady(youtubeView)
    }

    func youtubeViewDidBecomeReady(_ youtubeView: WKYTPlayerView){
//        youtubeView.load(withVideoId: model, playerVars: playVarsDic)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
//        addSubview(titleLabel)
        addSubview(youtubeView)
    }

    private func configure() {
        youtubeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundColor = .placeholderText
    }

    private func bind() {
//        titleLabel.text = model
        youtubeView.load(withVideoId: model!, playerVars: playVarsDic)
        
    }
    
}
