//
//  BinView.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 13.03.2022.
//

import UIKit

class BinView: UIView {
    
    func setupUI() {
        let image = UIImageView(image: UIImage(systemName: "trash"))
        image.contentMode = .scaleAspectFill
        self.addSubview(image)
        image.pin(to: self)
    }

    init(frame: CGRect, dropDelegate: UIDropInteractionDelegate) {
        super.init(frame: frame)
        setupUI()
        self.addInteraction(UIDropInteraction(delegate: dropDelegate))
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
