//
//  CollectionRegistrable.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 22.08.2020.
//

import Foundation

public enum Registrator {
    case nib(_ nib: UINib)
    case anyClass(_ any: AnyClass)
}

public protocol CollectionRegistrable {
    static var registrator: Registrator { get }
}

protocol CollectionRegistator {
    func register(_ registrable: CollectionRegistrable.Type, id: String)
}

extension UITableView: CollectionRegistator {
    public func register(_ registrable: CollectionRegistrable.Type, id: String) {
        switch registrable.registrator {
        case .nib(let nib):
            self.register(nib, forCellReuseIdentifier: id)
        case .anyClass(let any):
            self.register(any, forCellReuseIdentifier: id)
        }
    }
}

extension UICollectionView: CollectionRegistator {
    public func register(_ registrable: CollectionRegistrable.Type, id: String) {
        switch registrable.registrator {
        case .nib(let nib):
            self.register(nib, forCellWithReuseIdentifier: id)
        case .anyClass(let any):
            self.register(any, forCellWithReuseIdentifier: id)
        }
    }
}
