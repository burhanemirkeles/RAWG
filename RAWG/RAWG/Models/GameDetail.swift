//
//  GameDetail.swift
//  RAWG
//
//  Created by Emir Keleş on 10.07.2023.
//

import Foundation

struct GameDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let backgroundImage: String?
    let description : String?
    let redditUrl: String?
    let website: String?
    let genres: [Genre]
    let metacritic : Int?

    enum CodingKeys: String, CodingKey {
      case id
      case name
      case backgroundImage = "background_image"
      case description
      case redditUrl = "reddit_url"
      case website
      case genres
      case metacritic
    }
}
