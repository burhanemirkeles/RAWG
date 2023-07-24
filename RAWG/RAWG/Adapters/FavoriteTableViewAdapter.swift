//
//  FavoriteTableViewAdapter.swift
//  RAWG
//
//  Created by Emir Keleş on 23.07.2023.
//

import Foundation
import UIKit
import Carbon
import CoreData
class FavoriteTableViewAdapter: UITableViewAdapter{

  func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
    return true
  }

}
