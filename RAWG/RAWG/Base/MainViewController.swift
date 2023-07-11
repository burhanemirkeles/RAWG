//
//  ViewController.swift
//  RAWG
//
//  Created by Emir Keleş on 7.07.2023.
//

import UIKit

class MainViewController: UITabBarController {

  override func viewDidLoad() {

    super.viewDidLoad()
    view.backgroundColor = .white

    let firstViewController = GamesViewController()
    firstViewController.tabBarItem = UITabBarItem(title: "Games",
                                                  image: UIImage(named: "GamesIcon"),
                                                  tag: 0)

    let secondViewController = FavoritesViewController()
    secondViewController.tabBarItem = UITabBarItem(title: "Favorites",
                                                   image: UIImage(named: "FavoritesIcon"),
                                                   selectedImage: UIImage(named: "favoritesIconSelected"))


    viewControllers = [firstViewController, secondViewController]
  }

}
