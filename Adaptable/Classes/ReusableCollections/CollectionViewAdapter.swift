//
//  CollectionViewReusable.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 21.08.2020.
//

import UIKit

open class CollectionViewCellAdapter<Model, Configuration, Cell: UICollectionViewCell>: ViewAdapter<Model, Configuration, Cell> where Cell: Adaptable, Cell.Model == Model, Cell.Configuration == Configuration { }

extension CollectionViewCellAdapter: UICollectionViewCellReusable {
    public var reuseIdentifier: String {
        return String(describing: Model.self)
    }
    
    public func reuse(cell: UICollectionViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

extension CollectionViewCellAdapter where Cell: CollectionRegistrable {
    public func register(in collectionView: UICollectionView) {
        collectionView.register(Cell.self, id: self.reuseIdentifier)
    }
}


