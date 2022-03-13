//
//  DragedNotebook.swift
//  Shelves
//
//  Container that stores draged notebook to simplify drag'n'drop inside the app,
//  between shelves.
//
//  Created by Vsevolod Melnik on 13.03.2022.
//

import Foundation

class DragedNotebook: ObservableObject {
    static let shared = DragedNotebook()
    
    var draggedNotebook: Notebook?
}
