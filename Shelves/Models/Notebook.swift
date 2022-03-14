//
//  Notebook.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 09.03.2022.
//

import UIKit

class Notebook: Codable {
    var isNew: Bool = true
    var name: String = "New notebook"
    var shelf: Int = 0
    var pages: [String] = [" "] // Html code.
    var bookColor: String? = CGColor.hexFrom(color: CGColor(red: 0.4, green: 0.08, blue: 0, alpha: 1)) // Hex.
}
