//
//  ViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit

class ShelvesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0.05, alpha: 1)
        let shelf = ShelfView()
        view.addSubview(shelf)
        shelf.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        shelf.pinLeft(view: view)
        shelf.pinRight(view: view)
        shelf.setHeight(180)
    }


}

