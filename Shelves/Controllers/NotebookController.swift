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
        if let pageViewController = viewController as? PageController {
            let index = pageViewController.pageIndex
            if (index > 0) {
                let controller = PageController(pageIndex: index - 1, notebook: notebook!)
                return controller
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let pageViewController = viewController as? PageController {
            let index = pageViewController.pageIndex
            if (index + 1 < notebook!.pages.count) {
                let controller = PageController(pageIndex: index + 1, notebook: notebook!)
                return controller
            } else {
                notebook!.pages.append("<style>body {background-color: black; color: white; }h1 {background-color: black; color: white; }p {background-color: black; color: white; }</style><body><h1>Заголовок</h1><p> Текст</p></body>")
                let controller = PageController(pageIndex: index + 1, notebook: notebook!)
                return controller
            }
        }
        return nil
    }
    
}
