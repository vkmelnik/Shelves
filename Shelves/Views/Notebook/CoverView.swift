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
    var exportButton: UIButton?
    var coverController: CoverViewControllerProtocol?
    
    func setupUI() {
        let cover = NotebookView(frame: CGRect(x: 0, y: 0, width: 120, height: 210))
        cover.setupNotebook(notebook: notebook!)
        self.addSubview(cover)
        cover.pinLeft(to: self.leadingAnchor, 20)
        cover.setWidth(120)
        cover.setHeight(210)
        cover.pinTop(to: self.safeAreaLayoutGuide.topAnchor, 20)
        self.cover = cover
        
        let colorButton = UIButton()
        colorButton.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        colorButton.setTitle("Выбрать цвет", for: .normal)
        self.addSubview(colorButton)
        colorButton.pinLeft(to: cover.trailingAnchor, 20)
        colorButton.pinRight(to: self.trailingAnchor, 20)
        colorButton.pinTop(to: self.topAnchor, 20)
        self.colorButton = colorButton
        
        let exportButton = UIButton()
        exportButton.addTarget(self, action: #selector(export), for: .touchUpInside)
        exportButton.setTitle("Экспортировать", for: .normal)
        self.addSubview(exportButton)
        exportButton.pinLeft(to: cover.trailingAnchor, 20)
        exportButton.pinRight(to: self.trailingAnchor, 20)
        exportButton.pinTop(to: colorButton.bottomAnchor, 20)
        self.colorButton = exportButton
    }
    
    @objc
    func export() {
        coverController?.saveAsPdf()
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
