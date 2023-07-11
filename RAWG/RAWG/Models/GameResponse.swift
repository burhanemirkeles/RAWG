//
//  GameResponse.swift
//  RAWG
//
//  Created by Emir Keleş on 10.07.2023.
//

import Foundation

struct GameResponse: Codable {
  
    var results: [Game]
    var next: String?

}
