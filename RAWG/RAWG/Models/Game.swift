//
//  Game.swift
//  RAWG
//
//  Created by Emir Keleş on 10.07.2023.
//

import Foundation

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let genres: [Genre]?
    let gameImage: String?
    let metacritic: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gameImage = "background_image"
        case metacritic
        case genres

    }
}
