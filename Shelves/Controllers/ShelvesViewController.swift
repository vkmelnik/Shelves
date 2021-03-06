//
//  ViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit
import UniformTypeIdentifiers

/*
 ShelvesView controller.
 */
class ShelvesViewController: UIViewController {
    
    var notebooks: [Notebook] = []
    var shelvesCount = 1
    var shelvesView: ShelvesView?
    var binView: BinView?
    var coverChangeView: CoverChangeView?
    var notebookController: NotebookController?
    let pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
    var newNotebookNumber: Int = 1
    
    var doneButton: UIBarButtonItem?
    
    func setupView() {
        let shelvesView = ShelvesView()
        view.addSubview(shelvesView)
        shelvesView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 0)
        shelvesView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 0)
        shelvesView.pinLeft(to: view.leadingAnchor, 0)
        shelvesView.pinRight(to: view.trailingAnchor, 0)
        shelvesView.configure()
        self.shelvesView = shelvesView
        
        let binView = BinView(frame: CGRect(x: 0, y: 0, width: 120, height: 120), dropDelegate: self)
        view.addSubview(binView)
        binView.pinRight(to: view.trailingAnchor)
        binView.pinBottom(to: view.bottomAnchor)
        binView.setWidth(40)
        binView.setHeight(40)
        self.binView = binView
        
        let coverChangeView = CoverChangeView(frame: CGRect(x: 0, y: 0, width: 120, height: 120), dropDelegate: self)
        view.addSubview(coverChangeView)
        coverChangeView.pinRight(to: binView.leadingAnchor, 10)
        coverChangeView.pinBottom(to: view.bottomAnchor)
        coverChangeView.setWidth(40)
        coverChangeView.setHeight(40)
        self.coverChangeView = coverChangeView
    }
    
    func setupTableView() {
        shelvesView?.tableView?.delegate = self
        shelvesView?.tableView?.dataSource = self
        shelvesView?.tableView?.register(ShelfTableViewCell.self, forCellReuseIdentifier: "ShelfTableViewCell")
    }
    
    private func addNewNotebooks() {
        var hasNewOnShelves = [Bool](repeating: false, count: shelvesCount)
        var isNewShelve = [Bool](repeating: true, count: shelvesCount)
        for i in 0..<notebooks.count {
            if let number = Int(notebooks[i].name) {
                if (number >= newNotebookNumber) {
                    newNotebookNumber = number + 1
                }
            }
            if (notebooks[i].isNew) {
                hasNewOnShelves[notebooks[i].shelf] = true
            } else {
                isNewShelve[notebooks[i].shelf] = false
            }
        }
        for i in 0..<shelvesCount {
            if (!hasNewOnShelves[i]) {
                let newNotebook = Notebook()
                newNotebook.shelf = i
                newNotebook.name = String(newNotebookNumber)
                newNotebookNumber += 1
                notebooks.append(newNotebook)
            }
        }
        // Create new shelve if needed.
        var newShelves = 0
        for i in 0..<shelvesCount {
            if (isNewShelve[i]) {
                newShelves += 1
            }
        }
        if (newShelves == 0) {
            let newNotebook = Notebook()
            newNotebook.shelf = shelvesCount
            newNotebook.name = String(newNotebookNumber)
            newNotebookNumber += 1
            notebooks.append(newNotebook)
            shelvesCount += 1
        }
    }
    
    func loadNotebooks() {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let files = FileManager.default.urls(for: .documentDirectory, skipsHiddenFiles: true)
            for element in files! {
                do {
                    if element.lastPathComponent.hasSuffix("shelves") { // checks the extension
                        let jsonString = try String(contentsOf: documentDirectory.appendingPathComponent(element.lastPathComponent), encoding: .utf8)
                        let notebook = try JSONDecoder().decode(Notebook.self, from: jsonString.data(using: .utf8)!)
                            notebooks.append(notebook)
                        if (notebook.shelf + 2 > shelvesCount) {
                            shelvesCount = notebook.shelf + 2
                        }
                    }
                } catch {
                    print("Can't read " + element.lastPathComponent + " " + error.localizedDescription)
                }
            }
        }
        addNewNotebooks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        loadNotebooks()
        setupView()
        setupTableView()
        self.navigationItem.title = "??????????????"
        
        let doneButton = UIBarButtonItem(title: "????????????", style: .plain, target: self, action: #selector(doneEditing))
        self.doneButton = doneButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
          
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func doneEditing() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNewNotebooks()
        shelvesView?.tableView?.reloadData()
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        navigationItem.setRightBarButton(doneButton, animated: false)
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        navigationItem.setRightBarButton(nil, animated: false)
    }

}

extension ShelvesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelvesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShelfTableViewCell()
        cell.setShelfNumber(number: indexPath.item)
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
    func moveNotebook(notebook: Notebook, shelf: Int) {
        notebook.shelf = shelf
        NotebookController.saveNotebook(notebook: notebook)
        addNewNotebooks()
        self.shelvesView?.tableView?.reloadData()
    }
    
    func renameNotebook(notebook: Notebook, newName: String) {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let oldName = notebook.name
                notebook.name = newName
                try FileManager.default.moveItem(at: documentDirectory.appendingPathComponent(oldName + ".shelves"), to: documentDirectory.appendingPathComponent(newName + ".shelves"))
                // Rename images folder.
                let folderURL = documentDirectory.appendingPathComponent("\(oldName)")
                let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
                if !folderExists {
                    try FileManager.default.moveItem(at: folderURL, to: documentDirectory.appendingPathComponent("\(newName)"))
                }
            }
        } catch {
            print("Can't rename file \(notebook.name) to \(newName) \(error)")
        }
    }
    
    
    func deleteNotebook(notebook: Notebook) {
        let deleteAlert = UIAlertController(title: "???????????????? ??????????????", message: "?????????????? ???????????????", preferredStyle: UIAlertController.Style.alert)

        deleteAlert.addAction(UIAlertAction(title: "????", style: .default, handler: { (action: UIAlertAction!) in
            do {
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                    in: .userDomainMask).first {
                    try FileManager.default.removeItem(at: documentDirectory.appendingPathComponent(notebook.name + ".shelves"))
                    for i in 0..<self.notebooks.count {
                        if (self.notebooks[i].name == notebook.name) {
                            self.notebooks.remove(at: i)
                            self.addNewNotebooks()
                            self.shelvesView?.tableView?.reloadData()
                            return
                        }
                    }
                    
                    let folderURL = documentDirectory.appendingPathComponent("\(notebook.name)")
                    let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
                    if !folderExists {
                        try FileManager.default.removeItem(at: folderURL)
                    }
                }
            } catch {
                print("Can't delete file " + notebook.name + " \(error)")
            }
        }))

        deleteAlert.addAction(UIAlertAction(title: "??????", style: .cancel, handler: { (action: UIAlertAction!) in
            // Do nothing.
        }))

        present(deleteAlert, animated: true, completion: nil)
    }
    
    func openNotebook(notebook: Notebook) {
        let dataSource = NotebookController(notebook: notebook)
        pageViewController.dataSource = dataSource
        pageViewController.delegate = dataSource
        self.notebookController = dataSource
        let controller = PageController(pageIndex: 0, notebook: notebook, parent: pageViewController)
        print(notebook.pages[0])
        pageViewController.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        self.navigationController?.pushViewController(pageViewController, animated: false)
    }
}

extension ShelvesViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        if interaction.view == binView {
            if let notebook = DragedNotebook.shared.draggedNotebook {
                deleteNotebook(notebook: notebook)
                DragedNotebook.shared.draggedNotebook = nil
            }
        } else if interaction.view == coverChangeView {
            if let notebook = DragedNotebook.shared.draggedNotebook {
                let coverViewController = CoverViewController(notebook: notebook)
                DragedNotebook.shared.draggedNotebook = nil
                self.navigationController?.pushViewController(coverViewController, animated: true)
            }
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
            // Propose to the system to copy the item from the source app
        return UIDropProposal(operation: .move)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
}
