//
//  ViewControllerRouter.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit

protocol ViewControllerRouter {
    func openNotebook(notebook: Notebook)
    func deleteNotebook(notebook: Notebook)
    func renameNotebook(notebook: Notebook, newName: String)
    func moveNotebook(notebook: Notebook, shelf: Int)
}
