//
//  ViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit

/*
 ShelvesView controller.
 */
class ShelvesViewController: UIViewController {
    
    var shelvesView: ShelvesView?
    var notebookController: NotebookController?
    let pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    
    func setupView() {
        let shelvesView = ShelvesView()
        view.addSubview(shelvesView)
        shelvesView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 0)
        shelvesView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 0)
        shelvesView.pinLeft(to: view.leadingAnchor, 0)
        shelvesView.pinRight(to: view.trailingAnchor, 0)
        shelvesView.configure()
        self.shelvesView = shelvesView
    }
    
    func setupTableView() {
        shelvesView?.tableView?.delegate = self
        shelvesView?.tableView?.dataSource = self
        shelvesView?.tableView?.register(ShelfTableViewCell.self, forCellReuseIdentifier: "ShelfTableViewCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupTableView()
    }

}

extension ShelvesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell()
        cell.setupRouter(router: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0;
    }
}

extension ShelvesViewController: ViewControllerRouter {
    func openNotebook(notebook: Notebook) {
        let dataSource = NotebookController(notebook: notebook)
        pageViewController.dataSource = dataSource
        pageViewController.delegate = dataSource
        self.notebookController = dataSource
        let controller = PageViewController(pageIndex: 0, html: notebook.pages[0])
        pageViewController.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        self.navigationController?.pushViewController(pageViewController, animated: false)
    }
    
}
