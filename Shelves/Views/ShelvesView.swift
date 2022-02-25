//
//  ShelvesView.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 25.02.2022.
//

import UIKit

/*
 View, that contains shelves with notebooks.
 */
class ShelvesView: UIView {
    
    public var tableView: UITableView?
    
    func configure() {
        let tableView = UITableView()
        addSubview(tableView)
        tableView.pinTop(to: safeAreaLayoutGuide.topAnchor, 0)
        tableView.pinBottom(to: safeAreaLayoutGuide.bottomAnchor, 0)
        tableView.pinLeft(to: self.leadingAnchor, 0)
        tableView.pinRight(to: self.trailingAnchor, 0)
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = .clear
        self.tableView = tableView
    }
    
}
