//
//  NotebookCell.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit

// Collection view cell that displays a notebook and opens it on tap.
class NotebookCell: UICollectionViewCell {
    
    var notebookView: NotebookView?
    
    func setupNotebook(notebook: Notebook) {
        notebookView?.setupNotebook(notebook: notebook)
    }
    
    public func setupRouter(router: ViewControllerRouter) {
        notebookView?.setupRouter(router: router)
    }
    
    func setColor(color: CGColor) {
        notebookView?.setColor(color: color)
    }
    
    func getNotebook() -> Notebook {
        return (notebookView?.notebook)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let notebookView = NotebookView(frame: frame)
        self.addSubview(notebookView)
        notebookView.pin(to: self)
        isUserInteractionEnabled = true
        self.notebookView = notebookView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
