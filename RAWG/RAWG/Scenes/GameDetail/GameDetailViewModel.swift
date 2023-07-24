//
//  GameDetailViewModel.swift
//  RAWG
//
//  Created by Emir Keleş on 22.07.2023.
//

import Foundation
import CoreData

class GameDetailViewModel {

  weak var delegate: GamesViewModelDelegate?
  var gameDetail: GameDetail?
  var id: Int?

}
