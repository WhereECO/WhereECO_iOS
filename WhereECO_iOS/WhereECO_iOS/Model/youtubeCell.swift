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
 
    // Youtube Player Variable
    let playVarsDic = ["playsinline": 1]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func youtubeViewDidBecomeReady(_ youtubeView: WKYTPlayerView, id: String){
        youtubeView.load(withVideoId: id, playerVars: playVarsDic)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
