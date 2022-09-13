//
//  youtubeCell.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/12.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

class youtubeCell: UICollectionViewCell {
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }

    var model: String? { didSet { bind() } }

    lazy var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    
    lazy var playerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: "NcSUweIWMTc", playerVars: ["playsinline" : 1])
        return playerView
    }()
    
    func playerViewDidBecomeReady(playerView: YTPlayerView) {
        playerView.playVideo()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func addSubviews() {
        addSubview(titleLabel)
    }

    private func configure() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundColor = .placeholderText
    }

    private func bind() {
        titleLabel.text = model
//        playerView = model
    }
    
}
