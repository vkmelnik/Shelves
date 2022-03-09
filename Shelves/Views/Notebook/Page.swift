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
        editor.html = "<h1>My Awesome Editor</h1>Now I am editing in <em>style.</em>"
        self.addSubview(editor)
        editor.pin(to: self)
        self.editor = editor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
