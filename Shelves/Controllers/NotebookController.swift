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
        if let pageViewController = viewController as? PageViewController {
            let index = pageViewController.pageIndex
            if (index > 0) {
                let controller = PageViewController(pageIndex: index - 1, html: notebook!.pages[index - 1])
                return controller
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let pageViewController = viewController as? PageViewController {
            let index = pageViewController.pageIndex
            if (index + 1 < notebook!.pages.count) {
                let controller = PageViewController(pageIndex: index + 1, html: notebook!.pages[index + 1])
                return controller
            } else {
                notebook!.pages.append("")
                let controller = PageViewController(pageIndex: index + 1, html: notebook!.pages[index + 1])
                return controller
            }
        }
        return nil
    }
    
}
