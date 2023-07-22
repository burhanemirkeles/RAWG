//
//  UIImageView+Extension.swift
//  RAWG
//
//  Created by Emir Keleş on 11.07.2023.
//

import UIKit
import Foundation

extension UIImageView {

  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
  
}
