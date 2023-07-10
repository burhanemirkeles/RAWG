//
//  Genre.swift
//  RAWG
//
//  Created by Emir Keleş on 10.07.2023.
//

import Foundation

struct Genre: Codable {
  let name: String?

  enum CodingKeys: String, CodingKey {
    case name
  }
}
