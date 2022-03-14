//
//  Cover.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 14.03.2022.
//

import UIKit

class CoverView: UIView {
    
    let notebook: Notebook?
    var cover: NotebookView?
    var colorButton: UIButton?
    var coverController: CoverViewControllerProtocol?
    
    func setupUI() {
        let cover = NotebookView(frame: CGRect(x: 0, y: 0, width: 200, height: 360))
        cover.setupNotebook(notebook: notebook!)
        self.addSubview(cover)
        cover.pinCenter(to: self.centerXAnchor)
        cover.setWidth(200)
        cover.setHeight(360)
        cover.pinTop(to: self.safeAreaLayoutGuide.topAnchor, 20)
        self.cover = cover
        
        let colorButton = UIButton()
        colorButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        colorButton.setTitle("Выбрать цвет", for: .normal)
        self.addSubview(colorButton)
        colorButton.pinCenter(to: self.centerXAnchor)
        colorButton.pinTop(to: cover.bottomAnchor, 10)
        self.colorButton = colorButton
    }
    
    @objc
    func changeColor() {
        coverController?.changeCoverColor()
    }

    init(frame: CGRect, notebook: Notebook, coverController: CoverViewControllerProtocol) {
        self.notebook = notebook
        self.coverController = coverController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
