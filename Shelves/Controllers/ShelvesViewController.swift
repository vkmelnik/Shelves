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
    
    var notebooks: [Notebook] = []
    var shelvesCount = 1
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
    
    func loadNotebooks() {
        let fileManager = FileManager.default
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: documentDirectory.path)!
            while let element = enumerator.nextObject() as? String {
                do {
                    if element.hasSuffix("shelves") { // checks the extension
                        let jsonString = try String(contentsOf: documentDirectory.appendingPathComponent(element), encoding: .utf8)
                        let notebook = try JSONDecoder().decode(Notebook.self, from: jsonString.data(using: .utf8)!)
                            notebooks.append(notebook)
                        if (notebook.shelf + 2 > shelvesCount) {
                            shelvesCount = notebook.shelf + 2
                        }
                    }
                } catch {
                    print("Can't read " + element + " " + error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadNotebooks()
        setupView()
        setupTableView()
    }

}

extension ShelvesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelvesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell()
        for notebook in notebooks {
            if (notebook.shelf == indexPath.item) {
                cell.putNotebook(notebook: notebook)
            }
        }
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
        let controller = PageController(pageIndex: 0, notebook: notebook)
        pageViewController.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        self.navigationController?.pushViewController(pageViewController, animated: false)
    }
    
}
