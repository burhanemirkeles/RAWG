//
//  FavoritesViewController.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import UIKit
import Carbon

class FavoritesViewController: UIViewController {

  let favoritesView = FavoritesView()
  private let tableView: UITableView = UITableView()
  var viewModel: FavoritesViewModel = FavoritesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(favoritesView)
    configureFavoritesView(favoritesView)

    configureTableView()

  }

  private func configureFavoritesView(_ view: UIView) {

    favoritesView.snp.makeConstraints {
      $0.top.equalTo(0)
      $0.leading.trailing.equalTo(0)
      $0.height.equalTo(favoritesView.snp.height)
    }
  }

  private func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(favoritesView.snp.bottom)
      $0.leading.equalTo(0)
      $0.trailing.equalTo(0)
      $0.bottom.equalToSuperview().offset(-82)
    }
    tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
  }

}

