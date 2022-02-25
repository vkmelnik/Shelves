//
//  ShelfTableViewCell.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 25.02.2022.
//

import UIKit

class ShelfTableViewCell: UITableViewCell {
    
    var shelf: ShelfView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell() {
        let shelf = ShelfView()
        contentView.addSubview(shelf)
        shelf.pinLeft(to: self.leadingAnchor)
        shelf.pinRight(to: self.trailingAnchor)
        shelf.pinTop(to: self.topAnchor)
        shelf.setHeight(180)
        self.shelf = shelf
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
