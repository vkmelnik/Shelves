//
//  NotebookController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 09.03.2022.
//

import UIKit

class NotebookController: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var notebook: Notebook?
    
    init(notebook: Notebook) {
        self.notebook = notebook
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let pageController = viewController as? PageController {
            let index = pageController.pageIndex
            if (index > 0) {
                let controller = PageController(pageIndex: index - 1, notebook: notebook!, parent: pageViewController)
                return controller
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let pageController = viewController as? PageController {
            let index = pageController.pageIndex
            if (index + 1 < notebook!.pages.count) {
                let controller = PageController(pageIndex: index + 1, notebook: notebook!, parent: pageViewController)
                return controller
            } else {
                notebook!.pages.append("")
                let controller = PageController(pageIndex: index + 1, notebook: notebook!, parent: pageViewController)
                return controller
            }
        }
        return nil
    }
    
    static func saveNotebook(notebook: Notebook) {
        do {
            notebook.isNew = false
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(notebook)
            let json = String(data: jsonData, encoding: .utf8)

            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent(notebook.name + ".shelves")
                try json!.write(to: pathWithFilename,
                                    atomically: true,
                                    encoding: .utf8)
            }
        } catch {
            print("Unable to save notebook.")
        }
    }
    
}
