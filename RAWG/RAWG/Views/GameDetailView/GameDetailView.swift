//
//  GameDetailView.swift
//  RAWG
//
//  Created by Emir Keleş on 20.07.2023.
//

import Foundation
import UIKit
import SnapKit
import Carbon

final class GameDetailView: UIView, Component {

  func render(in content: GameDetailView) { }

  func renderContent() -> GameDetailView {
    return self
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: 100)
  }

  var id: Int = 0
  var titleLabel: UILabel = UILabel()
  var metaScoreLabel: UILabel = UILabel()
  var gameDescriptionLabel: UILabel = UILabel()
  var gameDescription: UILabel = UILabel()
  var imageView = UIImageView()
  var visitRedditButton = UIButton()
  var visitWebsiteButton = UIButton()
  var redditUrl: String?
  var websiteUrl: String?
  var firstSeperatorView = UIView()
  var secondSepartorView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureViews() {

    self.addSubview(imageView)
    self.addSubview(titleLabel)
    self.addSubview(metaScoreLabel)
    self.addSubview(gameDescriptionLabel)
    self.addSubview(gameDescription)
    self.addSubview(firstSeperatorView)
    self.addSubview(visitRedditButton)
    self.addSubview(secondSepartorView)
    self.addSubview(visitWebsiteButton)

    titleLabel.font = UIFont(name: Fonts.Roboto.bold, size: 36)
    titleLabel.textColor = .white
    titleLabel.textAlignment = .right

    gameDescription.text = "Game Description"
    gameDescription.font = UIFont(name: Fonts.Roboto.regular, size: 12)
    gameDescription.numberOfLines = 4
    gameDescription.translatesAutoresizingMaskIntoConstraints = false

    firstSeperatorView.backgroundColor = .gray

    visitRedditButton.setTitle("Visit Reddit", for: .normal)
    visitRedditButton.setTitleColor(.black, for: .normal)
    visitRedditButton.titleLabel?.font = UIFont(name: Fonts.Roboto.regular, size: 18)
    visitRedditButton.contentHorizontalAlignment = .left

    visitRedditButton.addTarget(self, action: #selector(visitButtonTapped), for: .touchUpInside)

    secondSepartorView.backgroundColor = .gray

    visitWebsiteButton.setTitle("Visit Website", for: .normal)
    visitWebsiteButton.setTitleColor(.black, for: .normal)
    visitWebsiteButton.titleLabel?.font = UIFont(name: Fonts.Roboto.regular, size: 18)
    visitWebsiteButton.contentHorizontalAlignment = .left

    visitWebsiteButton.addTarget(self, action: #selector(visitButtonTapped), for: .touchUpInside)
  }

  @objc func visitButtonTapped() {
    if let redditUrl = redditUrl, let url = URL(string: redditUrl) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    if let websiteUrl = websiteUrl, let url = URL(string: websiteUrl) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }

  private func setupConstraints() {
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(0)
      $0.left.right.equalToSuperview()
      $0.height.equalTo(292)
      $0.leading.trailing.equalTo(0)
    }

    titleLabel.snp.makeConstraints {
      $0.bottom.equalTo(imageView.snp.bottom).offset(-16)
      $0.left.equalToSuperview().offset(16)
      $0.right.equalToSuperview().offset(-16)
    }

    gameDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(16)
      $0.left.equalTo(16)
      $0.right.equalTo(-16)
    }

    gameDescription.snp.makeConstraints {
      $0.top.equalTo(gameDescriptionLabel.snp.bottom).offset(8)
      $0.left.equalTo(16)
      $0.right.equalTo(-16)
      $0.height.equalTo(82)
    }

    firstSeperatorView.snp.makeConstraints {
      $0.top.equalTo(gameDescription.snp.bottom).offset(16)
      $0.left.equalTo(16)
      $0.right.equalTo(-16)
      $0.height.equalTo(1)
    }

    visitRedditButton.snp.makeConstraints {
      $0.top.equalTo(firstSeperatorView.snp.bottom).offset(32)
      $0.left.equalTo(16)
      $0.right.equalTo(-16)
    }

    secondSepartorView.snp.makeConstraints {
      $0.top.equalTo(visitRedditButton.snp.bottom).offset(16)
      $0.left.equalTo(16)
      $0.right.equalTo(-16)
      $0.height.equalTo(1)
    }

    visitWebsiteButton.snp.makeConstraints {
      $0.top.equalTo(secondSepartorView.snp.bottom).offset(32)
      $0.left.equalTo(16)
    }

  }
}
