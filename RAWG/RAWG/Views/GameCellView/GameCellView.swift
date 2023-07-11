//
//  GameCellView.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import Foundation
import Carbon
import SnapKit

final class GameCellView: UIView {
  var id: Int = 0
  var titleLabel: UILabel = UILabel()
  var metacriticLabel: UILabel = UILabel()
  var metaScoreLabel: UILabel = UILabel()
  var genreTitleLabel: UILabel = UILabel()
  var imageView = UIImageView()

  weak var delegate: GameCellViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureViews()
    setupUI()
    addTapGesture()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureViews() {
    addSubview(titleLabel)
    addSubview(metacriticLabel)
    addSubview(metaScoreLabel)
    addSubview(genreTitleLabel)
    addSubview(imageView)
  }

  private func setupUI() {

    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.trailing.equalTo(-16)
      $0.leading.equalTo(152)
    }

    metacriticLabel.snp.makeConstraints { make in
      make.top.equalTo(84)
      make.trailing.equalTo(-147)
      make.leading.equalTo(152)
    }

    metaScoreLabel.snp.makeConstraints { make in
      make.top.equalTo(metacriticLabel)
      make.leading.equalTo(metacriticLabel.snp.trailing).offset(2)
      make.bottom.equalTo(metacriticLabel)
    }

    genreTitleLabel.snp.makeConstraints { make in
      make.top.equalTo(metacriticLabel.snp.bottom).offset(8)
      make.trailing.equalTo(-16)
      make.leading.equalTo(152)
    }

    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(16)
      make.leading.equalTo(16)
      make.trailing.equalTo(titleLabel.snp.leading).offset(-16)
      make.bottom.equalToSuperview().offset(16)
      make.height.equalTo(104)
      make.width.equalTo(120)
    }
  }

  private func addTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gameCellTapped))
    self.isUserInteractionEnabled = true
    self.addGestureRecognizer(tapGesture)
  }

  @objc func gameCellTapped() {
     self.delegate?.didSelect()

     let gameDetailViewController = GameDetailViewController()

    if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
       gameDetailViewController.gameId = self.id
       gameDetailViewController.getGameDetail()
       navigationController.pushViewController(gameDetailViewController, animated: true)
     }
   }
}

// MARK: GameCellViewDelegate
protocol GameCellViewDelegate: AnyObject {
  func didSelect()
}

final public class GameCellViewModel {

}
