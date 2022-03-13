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
        let editor = RichEditorView(frame: self.bounds)
        editor.html = "<style>body {background-color: black; color: white; }h1 {background-color: black; color: white; }p {background-color: black; color: white; }</style><body></body>"
        self.addSubview(editor)
        editor.pinLeft(to: self.leadingAnchor, 5)
        editor.pinRight(to: self.trailingAnchor, 5)
        editor.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor, 5)
        editor.pinTop(to: self.safeAreaLayoutGuide.topAnchor, 5)
        editor.backgroundColor = .black
        editor.webView.backgroundColor = .black
        editor.setTextColor(.white)
              
        self.editor = editor
    }
    
    public func setHtml(html: String) {
        editor?.html = html
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
