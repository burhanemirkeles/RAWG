//
//  EmptyCellItem.swift
//  RAWG
//
//  Created by Emir Keleş on 20.07.2023.
//

import Foundation
import Carbon

struct EmptyCellItem : IdentifiableComponent {

  var id = 1
  let referenceSizeHeight: CGFloat = 136
  var labelText: String

  // MARK: - Component
  func render(in content: EmptyCellView) {
    content.emptyLabel.text = labelText
  }

  func referenceSize(in bounds: CGRect) -> CGSize? {
    return CGSize(width: bounds.width, height: referenceSizeHeight)
  }

  func renderContent() -> EmptyCellView {
    return EmptyCellView()
  }

  func shouldContentUpdate(with next: EmptyCellItem) -> Bool {
    return false
  }
  
}
