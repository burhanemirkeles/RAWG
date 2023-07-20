//
//  GameDetailItem.swift
//  RAWG
//
//  Created by Emir Keleş on 20.07.2023.
//

import Foundation
import Carbon
import Kingfisher

struct GameDetailItem: IdentifiableComponent {

  var gameDetail: GameDetail
  var id: Int {
    gameDetail.id
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: bounds.height)
  }

  func shouldContentUpdate(with next: GameDetailItem) -> Bool {
    return true
  }

  func renderContent() -> GameDetailView {
    return GameDetailView()
  }

  func render(in content: GameDetailView) {

    content.titleLabel.text = gameDetail.name

    if let imageView = gameDetail.backgroundImage, let url = URL(string: imageView) {
      let resizeProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 375, height: 292))
      let imageLoadingOptions: KingfisherOptionsInfo = [
        .processor(resizeProcessor),
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(0.2))
      ]
      content.imageView.kf.setImage(with: url, options: imageLoadingOptions)
    }

    content.gameDescriptionLabel.text = "Game Description"

    if let htmlData = gameDetail.description?.data(using: .utf8) {
      if let attributedString = try? NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
        let plainText = attributedString.string
        content.gameDescription.text = plainText
      }
    }


    content.redditUrl = gameDetail.redditUrl
    content.websiteUrl = gameDetail.website
  }
}
