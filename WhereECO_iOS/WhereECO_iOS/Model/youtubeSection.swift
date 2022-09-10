//
//  youtubeSection.swift
//  WhereECO_iOS
//
//  Created by 김하은 on 2022/09/08.
//

import UIKit
import SnapKit
import Then

enum youtubeSection {
  struct Concept {
    let image: UIImage
    let title: String
    let desc: String
  }
  struct Music {
    let image: UIImage
    let title: String
    let desc: String
  }
  
  case concept([Concept])
  case music([Music])
}
