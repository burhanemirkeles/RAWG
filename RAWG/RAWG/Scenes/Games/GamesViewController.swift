//
//  GamesViewController.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import UIKit
import Carbon
import SnapKit

class GamesViewController: UIViewController {

  let gamesView = GamesView()
  private let tableView: UITableView = UITableView()
  var viewModel: GamesViewModel = GamesViewModel()
  var isTypingAllowed: Bool = true

  private let renderer = Renderer(adapter: TableViewAdapter(),
                                  updater: UITableViewUpdater())

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(gamesView)
    configureGamesView(gamesView)

    viewModel.delegate = self
    viewModel.fetchGames()

    renderer.target = tableView

    gamesView.searchBar.delegate = self
    configureTableView()

  }

  private func configureGamesView(_ view: UIView) {

    gamesView.snp.makeConstraints {
      $0.top.equalTo(0)
      $0.leading.trailing.equalTo(0)
      $0.height.equalTo(gamesView.snp.height)
    }
  }

  private func configureTableView() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(gamesView.searchBar.snp.bottom)
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
      let emptyCell = CellNode(id: "EmptyCell",
                               EmptyCellItem(id: 1,
                                             labelText: "No game has been searched..."))
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
// MARK: GamesViewModelDelegate
extension GamesViewController: GamesViewModelDelegate {

  func didFetchGamesData() { render() }

  func searchGame() { render() }

  func didFetchMoreGames() { render() }

  func getGameDetail() { }

}

// MARK: SearchBarDelegate
extension GamesViewController: UISearchBarDelegate {
  private static let minimumSearchLimit = 3

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.games.removeAll()

    if let searchText = searchBar.text {
      if searchText.count >= viewModel.minimumCharacterLimitForSearch {
        viewModel.searchGames(text: searchText)
      }
    }
    searchBar.resignFirstResponder()
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {//cancel butona tıkladığımda
    searchBar.text = ""
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
    viewModel.games.removeAll()
    viewModel.fetchGames()
    didFetchGamesData()
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {//Tıkladığım anda
    searchBar.showsCancelButton = true
    viewModel.games.removeAll()
    render()
  }

  func searchbar(_ searchBar: UISearchBar) {
    viewModel.games.removeAll()
    render()
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.games.removeAll()

    if !isTypingAllowed {
      searchBar.text = searchText
      if searchText.count >= viewModel.minimumCharacterLimitForSearch {
        viewModel.searchGames(text: searchText)
      }
    }
  }

  func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

    if !isTypingAllowed {
      return false
    }

    isTypingAllowed = false

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
      self.isTypingAllowed = true
    }
    return true
  }

}
