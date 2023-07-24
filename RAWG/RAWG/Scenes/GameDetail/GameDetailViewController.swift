//
//  GameDetailViewController.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import Foundation
import Carbon
import UIKit
import CoreData

class GameDetailViewController: UIViewController, GamesViewModelDelegate {
  func didFetchGamesData() {
    render()
  }

  func searchGame() {
    render()
  }

  func didFetchMoreGames() {
    render()
  }

  func getGameDetail() {
    render()
  }

  var gameId: Int?
  let gameDetailView = GameDetailView()
  private let tableView: UITableView = UITableView()

  var context: NSManagedObjectContext!
  let gameStore = GameStore()
  
  private let renderer = Renderer(adapter: UITableViewAdapter(),
                                  updater: UITableViewUpdater())
  var viewModel: GamesViewModel = GamesViewModel()


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    viewModel.delegate = self
    viewModel.getDetailGames(gameID: gameId ?? 0)
    renderer.target = tableView
    configureTableView()
    addFavoriteButton()
    context = gameStore.persistentContainer.viewContext
  }

  func render() {
    var nodes: [CellNode] = []

    let gameDetailNode = CellNode(GameDetailItem(
      gameDetail: GameDetail(
        id: viewModel.gameDetail?.id ?? 0,
        name: viewModel.gameDetail?.name ?? "",
        backgroundImage: viewModel.gameDetail?.backgroundImage ?? "",
        description: viewModel.gameDetail?.description ?? "", redditUrl: viewModel.gameDetail?.redditUrl ?? "",
        website: viewModel.gameDetail?.website ?? "",
        genres: viewModel.gameDetail?.genres ?? [],
        metacritic: viewModel.gameDetail?.metacritic ?? 0
      )
    ))
    nodes.append(gameDetailNode)

    let detailSection = Section(id: "DetailSection", cells: nodes)
    renderer.render(detailSection)

  }

  func addFavoriteButton() {
    var title = ""
    if viewModel.checkIsGameFavorited(desiredGameId: gameId ?? 0) {
      title = "Favorited"
    } else {
      title = "Favorite"
    }
    let rightButton = UIBarButtonItem(title: title,
                                      style: .plain,
                                      target: self,
                                      action: #selector(favoriteButtonTapped))
    navigationItem.rightBarButtonItem = rightButton

  }

  @objc func favoriteButtonTapped() {
    let game = GameData(context: context)

    let gameDetail = GameDetail(
    id: viewModel.gameDetail?.id ?? 0,
    name: viewModel.gameDetail?.name ?? "",
    backgroundImage: viewModel.gameDetail?.backgroundImage ?? "",
    description: viewModel.gameDetail?.description ?? "",
    redditUrl: viewModel.gameDetail?.redditUrl ?? "",
    website: viewModel.gameDetail?.website ?? "",
    genres: viewModel.gameDetail?.genres ?? [],
    metacritic: viewModel.gameDetail?.metacritic ?? 0)

    let combinedString = viewModel.gameDetail?.genres.compactMap { $0.name }.joined(separator: ", ")

    game.gameId = Int32(gameDetail.id)
    game.gameName = gameDetail.name
    game.gameImage = gameDetail.backgroundImage
    game.gameGenres = combinedString
    game.gameMetacriticScore = gameDetail.metacritic != nil ? Int32(gameDetail.metacritic!) : 0

    if !viewModel.checkIsGameFavorited(desiredGameId: gameId ?? 0) {
      do {
        try context.save()
        print(game)
      } catch {
        print("Error while saving: \(error)")
      }
    }
  }

  private func configureTableView() {
    view.addSubview(tableView)

    tableView.snp.makeConstraints {
      $0.top.equalTo(88)
      $0.leading.equalTo(0)
      $0.trailing.equalTo(0)
      $0.bottom.equalToSuperview().offset(0)
    }
    tableView.separatorStyle = .none
  }
}
