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

  private let renderer = Renderer(adapter: TableViewAdapter(),
                                  updater: UITableViewUpdater())

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(favoritesView)
    configureFavoritesView(favoritesView)

    renderer.target = tableView

    viewModel.delegate = self

    configureTableView()
    render()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    render()
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
      $0.top.equalTo(favoritesView.navigationBar.snp.bottom)
      $0.leading.equalTo(0)
      $0.trailing.equalTo(0)
      $0.bottom.equalToSuperview().offset(-82)
    }
    tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
  }

  func render() {
    var nodes: [CellNode] = []
    if viewModel.games.isEmpty {
      let emptyCell = CellNode(id: "EmptyCell", EmptyCellItem())
      nodes.append(emptyCell)
    } else {
      for game in viewModel.games {
        let gameCell = CellNode(id: "GameCell", GameCellItem(game: game))
        nodes.append(gameCell)
      }
    }

    let gamesSection = Section(id: "gameSection", cells: nodes)
    renderer.render(gamesSection)
  }

}

extension FavoritesViewController: GamesViewModelDelegate {
  func didFetchGamesData() { render() }

  func searchGame() { }

  func didFetchMoreGames() { render() }

  func getGameDetail() { render() }
}
