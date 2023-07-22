//
//  FavoritesView.swift
//  RAWG
//
//  Created by Emir Keleş on 23.07.2023.
//

import Foundation
import Carbon

class FavoritesView: UIView {

  let navigationBarLabel: UILabel = UILabel()
  let navigationBar = UINavigationBar()

  private struct Const {

    static let referencedSizeHeight: Double = 100.0

    static let navigationBarBackgroundColor: UIColor = UIColor(red: 248,
                                                               green: 248,
                                                               blue: 248,
                                                               alpha: 0.92)
    static let navigationBarTopItemTitle: String = "Navigation Bar"

    static let labelText = "Favorites"
    static let labelFont = UIFont(name: Fonts.Roboto.bold, size: 34)
    static let labelTitleMinScaleFactor: CGFloat = 0.5

    struct NavigationBarConstraints {
      static let height = 140
      static let width = 375
    }

    struct LabelTitleConstraints {
      static let topOffset = 90
      static let leftOffset = 16
      static let rightOffset = 250
      static let bottomOffset = -10
      static let height = 42
      static let width = 110
    }
  }

  init() {
    super.init(frame: .zero)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupViews() {
    self.addSubview(navigationBar)
    navigationBar.addSubview(navigationBarLabel)

    navigationBar.layer.cornerRadius = .zero
    navigationBar.tintColor = .white
    navigationBar.topItem?.title = Const.navigationBarTopItemTitle
    navigationBar.backgroundColor = Const.navigationBarBackgroundColor

    navigationBarLabel.textColor = .black
    navigationBarLabel.textAlignment = .left
    navigationBarLabel.numberOfLines = .zero
    navigationBarLabel.lineBreakMode = .byWordWrapping
    navigationBarLabel.textColor = .black
    navigationBarLabel.adjustsFontSizeToFitWidth = true
    navigationBarLabel.minimumScaleFactor = Const.labelTitleMinScaleFactor
    navigationBarLabel.baselineAdjustment = .alignCenters
    navigationBarLabel.text = Const.labelText
    navigationBarLabel.font = Const.labelFont
  }
  func setupConstraints() {
    navigationBar.snp.makeConstraints {
      $0.height.equalTo(Const.NavigationBarConstraints.height)
      $0.width.equalTo(Const.NavigationBarConstraints.width)
      $0.left.equalToSuperview()
      $0.top.equalToSuperview()
      $0.right.equalToSuperview()
    }
    navigationBarLabel.snp.makeConstraints{
      $0.top.equalTo(navigationBar).offset(Const.LabelTitleConstraints.topOffset)
      $0.left.equalToSuperview().offset(Const.LabelTitleConstraints.leftOffset)
      $0.right.equalToSuperview().offset(Const.LabelTitleConstraints.rightOffset)
      $0.bottom.equalTo(navigationBar).offset(Const.LabelTitleConstraints.bottomOffset)
      $0.height.equalTo(Const.LabelTitleConstraints.height)
      $0.width.equalTo(Const.LabelTitleConstraints.width)
    }
  }
}

extension FavoritesView: Component {
  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: 100)
  }

  func renderContent() -> Content {
    return self
  }

  func render(in content: FavoritesView) { }
}
