//
//  UIImage+Extension.swift
//  RAWG
//
//  Created by Emir Keleş on 23.07.2023.
//

import UIKit

extension UIImage {

  func imageWithAlphaValue(_ alpha: CGFloat) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: .zero, blendMode: .normal, alpha: alpha)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

}
