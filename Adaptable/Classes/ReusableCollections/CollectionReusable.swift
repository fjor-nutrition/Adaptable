//
//  CollectionsReusable.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 21.08.2020.
//

import Foundation
import UIKit

public protocol CollectionReusable {
    var reuseIdentifier: String { get }
}

//MARK: - UITableView

public protocol UITableViewCellReusable: CollectionReusable {
    func reuse(cell: UITableViewCell)
}

public extension UITableView {
    func dequeueReusableCell(reusable: UITableViewCellReusable, indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: reusable.reuseIdentifier, for: indexPath)
        reusable.reuse(cell: cell)
        return cell
    }
}

//MARK: - UICollectionView

public protocol UICollectionViewCellReusable: CollectionReusable {
    func reuse(cell: UICollectionViewCell)
}

public protocol UICollectionViewSupplementaryReusable: CollectionReusable {
    var elementKind: String { get }
    func reuse(supplementary: UICollectionReusableView)
}

public extension UICollectionView {
    func dequeueReusableCell(reusable: UICollectionViewCellReusable, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: reusable.reuseIdentifier, for: indexPath)
        reusable.reuse(cell: cell)
        return cell
    }
    
    func dequeueSupplementary(reusable: UICollectionViewSupplementaryReusable, for indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = self.dequeueReusableSupplementaryView(ofKind: reusable.elementKind, withReuseIdentifier: reusable.reuseIdentifier, for: indexPath)
        reusable.reuse(supplementary: reusableView)
        return reusableView
    }
}
