//
//  GamesServiceProtocol.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import Foundation
import Alamofire

protocol GamesServiceProtocol {
  func getDefaultRequest(url: String,
                         method: HTTPMethod,
                         params: [String:AnyObject]) -> URLRequest

  func requestGetGames(completion: @escaping (Result<([Game], String?),
                                              Error>) -> Void)

  func requestGetGamesWithSearch(searchText: String,
                                 completion: @escaping (Result<[Game], Error>) -> Void)

  func requestGetGamesDetail(gameID: Int,
                             completion: @escaping (Result<GameDetail, Error>) -> Void)

  func requestGetMoreGames(nextPage: String?,
                           completion: @escaping (Result<([Game], String?), Error>) -> Void)
  
}
