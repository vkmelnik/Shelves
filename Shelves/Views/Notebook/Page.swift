//
//  Page.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit
import RichEditorView

class Page: UIView {
    
    var editor: RichEditorView?
    
    func setupUI() {
        let editor = RichEditorView()
        editor.backgroundColor = .black
        editor.webView.backgroundColor = .black
        editor.webView.isOpaque = false
        editor.html = "";
        self.addSubview(editor)
        editor.pinLeft(to: self.leadingAnchor, 5)
        editor.pinRight(to: self.trailingAnchor, 5)
        editor.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor, 5)
        editor.pinTop(to: self.safeAreaLayoutGuide.topAnchor, 5)
              
        self.editor = editor
    }
    
    public func setHtml(html: String) {
        editor?.html = html;
        editor?.setEditorFontColor(.blue)
        editor?.setEditorBackgroundColor(.black)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
