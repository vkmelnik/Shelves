//
//  CoverViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 14.03.2022.
//

import UIKit

class CoverViewController: UIViewController {
    
    var notebook: Notebook?
    var cover: CoverView?
    let picker = UIColorPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        view.backgroundColor = .black
        
        let cover = CoverView(frame: view.frame, notebook: notebook!, coverController: self)
        view.addSubview(cover)
        cover.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        cover.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        cover.pinLeft(to: view.leadingAnchor)
        cover.pinRight(to: view.trailingAnchor)
        cover.cover?.setupRouter(router: self)
        self.cover = cover
        // Do any additional setup after loading the view.
    }
    
    convenience init(notebook: Notebook) {
        self.init()
        self.notebook = notebook
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CoverViewController: CoverViewControllerProtocol {
    func changeCoverColor() {
        picker.selectedColor = UIColor(cgColor: CGColor.colorFrom(hex: notebook!.bookColor ?? "#888888") ?? CGColor(gray: 0.8, alpha: 1))

        self.present(picker, animated: true, completion: nil)
    }
}

extension CoverViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        notebook?.bookColor = CGColor.hexFrom(color: viewController.selectedColor.cgColor)
        cover?.cover?.setColor(color: viewController.selectedColor.cgColor)
        if let notebook = notebook {
            NotebookController.saveNotebook(notebook: notebook)
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        notebook?.bookColor = CGColor.hexFrom(color: viewController.selectedColor.cgColor)
        cover?.cover?.setColor(color: viewController.selectedColor.cgColor)
        if let notebook = notebook {
            NotebookController.saveNotebook(notebook: notebook)
        }
    }
}

extension CoverViewController: ViewControllerRouter {
    func openNotebook(notebook: Notebook) {
        changeCoverColor()
    }
    
    func deleteNotebook(notebook: Notebook) {
        return
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
    
    func moveNotebook(notebook: Notebook, shelf: Int) {
        return
    }
    
    
}
