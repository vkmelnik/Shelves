//
//  ShelfView.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 27.11.2021.
//

import UIKit

// View that displays a shelf with clickable notebooks.
class ShelfView: UIView {
    
    var notebooksCollection: UICollectionView?
    var separator: UIView?
    
    var router: ViewControllerRouter?
    
    // Setup collection view for notebooks.
    func setupCollectionView() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.sectionInset = UIEdgeInsets(top: 10, left: 20,
        bottom: 10, right: 20)
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.itemSize = CGSize(width: 90, height: 160)
        layoutFlow.minimumInteritemSpacing = 20
        layoutFlow.minimumLineSpacing = 20
        let notebooksCollection = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        notebooksCollection.backgroundColor = .clear
        self.addSubview(notebooksCollection)
        notebooksCollection.pinTop(to: safeAreaLayoutGuide.topAnchor)
        notebooksCollection.pinLeft(view: self)
        notebooksCollection.pinRight(view: self)
        notebooksCollection.setHeight(180)
        notebooksCollection.delegate = self
        notebooksCollection.dataSource = self
        notebooksCollection.register(NotebookCell.self, forCellWithReuseIdentifier: "notebookCell")
        
        self.notebooksCollection = notebooksCollection
    }
    
    // Setup separator, title and other elements of the shelf.
    func setupShelf() {
        let separator = UIView()
        separator.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        separator.layer.cornerRadius = 2
        self.addSubview(separator)
        separator.pinBottom(view: self, 2)
        separator.pinLeft(view: self, 5)
        separator.pinRight(view: self, 5)
        separator.setHeight(4)
        self.separator = separator
    }

    func setupShelfUI() {
        backgroundColor = .clear
        setupShelf()
        setupCollectionView()
    }
    
    func setupRouter(router: ViewControllerRouter) {
        self.router = router
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        setupShelfUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ShelfView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "notebookCell",
            for: indexPath
        ) as? NotebookCell
        cell?.setupRouter(router: router!)
        return cell ?? UICollectionViewCell()
    }
    
    
}
