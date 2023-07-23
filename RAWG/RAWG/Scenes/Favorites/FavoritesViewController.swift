//
//  FavoritesViewController.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

  let favoritesView = FavoritesView()
  private let tableView: UITableView = UITableView()
  var viewModel: FavoritesViewModel = FavoritesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(favoritesView)

  }
}

