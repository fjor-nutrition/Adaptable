//
//  CollectionViewReusable.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 21.08.2020.
//

import UIKit

public protocol UICollectionViewCellReusable: CollectionIdentifiable {
    func register(in collectionView: UICollectionView)
    func reuse(cell: UICollectionViewCell)
}

open class CollectionViewCellAdapter<Model, Configuration, Cell: UICollectionViewCell>: ViewAdapter<Model, Configuration, Cell> where Cell: Adaptable, Cell.Model == Model, Cell.Configuration == Configuration { }

extension CollectionViewCellAdapter: UICollectionViewCellReusable {
    public var id: String {
        return String(describing: Model.self)
    }
    
    public func register(in collectionView: UICollectionView) {
        collectionView.register(Cell.self, forCellWithReuseIdentifier: self.id)
    }
    
    public func reuse(cell: UICollectionViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

open class CollectionViewNibCellAdapter<Model, Configuration, Cell: UICollectionViewCell>: ViewAdapter<Model, Configuration, Cell> where Cell: Adaptable, Cell.Model == Model, Cell.Configuration == Configuration {
    private(set) var nib: UINib = UINib(nibName: String(describing: Cell.self), bundle: nil)
    
    convenience init(model: Model, configuration: Configuration, nib: UINib) {
        self.init(model: model, configuration: configuration)
        self.nib = nib
    }
    
}

extension CollectionViewNibCellAdapter: UICollectionViewCellReusable {
    public var id: String {
        return String(describing: Model.self)
    }
    
    public func register(in collectionView: UICollectionView) {
        collectionView.register(self.nib, forCellWithReuseIdentifier: self.id)
    }
    
    public func reuse(cell: UICollectionViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

public extension UICollectionView {
    func register(reusable: UICollectionViewCellReusable) {
        reusable.register(in: self)
    }
        
    func dequeueReusableCell(reusable: UICollectionViewCellReusable, indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: reusable.id, for: indexPath)
    }
}


