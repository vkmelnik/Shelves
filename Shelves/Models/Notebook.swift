//
//  Notebook.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 09.03.2022.
//

import Foundation

class Notebook: Codable {
    var isNew: Bool = true
    var name: String = "New notebook"
    var shelf: Int = 0
    var pages: [String] = ["<style>body {background-color: black; color: white; }h1 {background-color: black; color: white; }p {background-color: black; color: white; }</style><body><h1>Заголовок</h1><p> Текст</p></body>"] // Html code.
}
