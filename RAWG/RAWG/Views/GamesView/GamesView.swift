//
//  GamesView.swift
//  RAWG
//
//  Created by Emir Keleş on 22.07.2023.
//

import Foundation
import SnapKit
import Carbon
import UIKit

class GamesView: UIView, Component {

  let navigationBarLabel: UILabel = UILabel()
  let navigationBar = UINavigationBar()

  let searchBar = UISearchBar()
  let stackView = UIStackView()

  private struct Const {

    static let referencedSizeHeight: Double = 100.0

    static let navigationBarBackgroundColor: UIColor = UIColor(red: 248,
                                                               green: 248,
                                                               blue: 248,
                                                               alpha: 0.92)
    static let navigationBarTopItemTitle: String = "Navigation Bar"

    static let labelText = "Games"
    static let labelFont = UIFont(name: Fonts.Roboto.bold, size: 34)
    static let labelTitleMinScaleFactor: CGFloat = 0.5

    static let searchBarBackgroundColor: UIColor = UIColor(red: 142,
                                                           green: 142,
                                                           blue: 147,
                                                           alpha: 0.12)

    static let searchBarCornerRadius: CGFloat = 10.0
    static let searchBarPlaceholderText: String = "Search for the games"

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

    struct StackViewConstraints {
      static let topOffset = 2
      static let bottomOffset = -84
    }
  }

  init() {
    super.init(frame: .zero)
    setupViews()
    setupConstraints()
  }

  // MARK: - Component
  func render(in content: GamesView) { }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: Const.referencedSizeHeight)
  }

  func renderContent() -> GamesView {
    return self
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func setupConstraints() {
    navigationBar.snp.makeConstraints {
      $0.height.equalTo(Const.NavigationBarConstraints.height)
      $0.width.equalTo(Const.NavigationBarConstraints.width)
      $0.left.equalToSuperview()
      $0.top.equalToSuperview()
      $0.right.equalToSuperview()
    }
    navigationBarLabel.snp.makeConstraints {
      $0.top.equalTo(navigationBar).offset(Const.LabelTitleConstraints.topOffset)
      $0.left.equalToSuperview().offset(Const.LabelTitleConstraints.leftOffset)
      $0.right.equalToSuperview().offset(Const.LabelTitleConstraints.rightOffset)
      $0.bottom.equalTo(navigationBar).offset(Const.LabelTitleConstraints.bottomOffset)
      $0.height.equalTo(Const.LabelTitleConstraints.height)
      $0.width.equalTo(Const.LabelTitleConstraints.width)

    }
    stackView.snp.makeConstraints {
      $0.top.equalTo(navigationBar.snp.bottom).offset(Const.StackViewConstraints.topOffset)
      $0.bottom.equalToSuperview().offset(Const.StackViewConstraints.bottomOffset)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    searchBar.snp.makeConstraints { (make) in

    }
  }

  func setupViews () {
    self.addSubview(navigationBar)
    navigationBar.addSubview(navigationBarLabel)
    self.addSubview(stackView)
    stackView.addArrangedSubview(searchBar)

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

    stackView.axis = .vertical
    stackView.contentMode = .scaleToFill
    stackView.alignment = .fill
    stackView.spacing = .zero
    stackView.distribution = .fill
    stackView.backgroundColor = .gray


    searchBar.backgroundColor = Const.searchBarBackgroundColor
    searchBar.layer.cornerRadius = Const.searchBarCornerRadius
    searchBar.placeholder = Const.searchBarPlaceholderText
    searchBar.searchTextField.font = UIFont.systemFont(ofSize: 17)

  }
}
