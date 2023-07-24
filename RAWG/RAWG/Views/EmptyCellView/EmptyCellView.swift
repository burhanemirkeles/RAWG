//
//  EmptyCellView.swift
//  RAWG
//
//  Created by Emir Keleş on 20.07.2023.
//

import Foundation
import SnapKit
import Carbon

final class EmptyCellView: UIView {

  var emptyLabel: UILabel = UILabel()

  private struct Const {
    static let emptyLabelFont = UIFont(name: Fonts.Roboto.bold, size: 18)
    static let emptyLabelMinScaleFactor: CGFloat = 0.5

    static let emptyLabelTopOffset = 38
  }

  override init(frame: CGRect){
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews () {
    self.addSubview(emptyLabel)

    emptyLabel.textColor = .black
    emptyLabel.textAlignment = .center
    emptyLabel.numberOfLines = .zero
    emptyLabel.lineBreakMode = .byWordWrapping
    emptyLabel.textColor = .black
    emptyLabel.adjustsFontSizeToFitWidth = true
    emptyLabel.minimumScaleFactor = Const.emptyLabelMinScaleFactor
    emptyLabel.baselineAdjustment = .alignCenters
    emptyLabel.font = Const.emptyLabelFont
  }

  func setupConstraints() {
    emptyLabel.snp.makeConstraints{
      $0.top.equalToSuperview().offset(Const.emptyLabelTopOffset)
      $0.centerX.equalToSuperview()
    }

  }
}
