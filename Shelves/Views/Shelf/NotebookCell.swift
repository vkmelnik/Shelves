//
//  NotebookCell.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit

// Collection view cell that displays a notebook and opens it on tap.
class NotebookCell: UICollectionViewCell {
    
    var notebook: Notebook?
    var notebookIcon: UIButton?
    var title: UITextField?
    private var backColor: CGColor?
    var bookColor: CGColor? = CGColor(red: 0.4, green: 0.08, blue: 0, alpha: 1)
    
    var router: ViewControllerRouter?
    
    // Draw notebook icon.
    func drawNotebook(width: Int = 90, height: Int = 128) {
        let notebookIcon = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        notebookIcon.addTarget(self, action: #selector(onButtonPressed), for: .touchUpInside)
        let backLayer = CALayer()
        backLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        backLayer.cornerRadius = 12
        backLayer.backgroundColor = backColor
        self.layer.addSublayer(backLayer)
        
        let pageLayer = CALayer()
        pageLayer.frame = CGRect(x: 3, y: 3, width: width - 8, height: height - 6)
        pageLayer.cornerRadius = 9
        pageLayer.backgroundColor = CGColor(red: 0.8, green: 0.77, blue: 0.64, alpha: 0.8)
        self.layer.addSublayer(pageLayer)
        
        let frontLayer = CALayer()
        frontLayer.frame = CGRect(x: 0, y: 0, width: width - 7, height: height)
        frontLayer.cornerRadius = 12
        frontLayer.backgroundColor = bookColor! // TODO: fix!
        self.layer.addSublayer(frontLayer)
        
        let lineLayer = CALayer()
        lineLayer.frame = CGRect(x: width - 25, y: 0, width: 6, height: height)
        lineLayer.backgroundColor = backColor
        self.layer.addSublayer(lineLayer)
        
        self.addSubview(notebookIcon)
        self.notebookIcon = notebookIcon
    }
    
    private func setBackColor() {
        if let bookColor = bookColor {
            let components = bookColor.components!
            let red = max(components[0] - 0.15, 0)
            let green = max(components[1] - 0.15, 0)
            let blue = max(components[2] - 0.15, 0)
            let alpha = components[3]
            backColor = CGColor(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            backColor = CGColor(gray: 0.25, alpha: 1)
        }
    }
    
    func addTitle(_ text: String) {
        let title = UITextField()
        title.text = text
        title.textColor = .label
        title.textAlignment = .center
        self.addSubview(title)
        title.pinTop(to: notebookIcon!.bottomAnchor, 10)
        title.pinCenter(to: notebookIcon!.centerXAnchor)
        title.pinLeft(view: self)
        title.pinRight(view: self)
        self.title = title
    }
    
    public func setupRouter(router: ViewControllerRouter) {
        self.router = router
    }
    
    @objc
    func onButtonPressed() {
        router?.openNotebook(notebook: notebook!)
    }
    
    func setupNotebook(notebook: Notebook) {
        self.notebook = notebook
        title?.text = notebook.name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackColor()
        drawNotebook()
        isUserInteractionEnabled = true
        addTitle("New book")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
