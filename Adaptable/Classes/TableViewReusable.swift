//
//  TableViewAdaptable.swift
//  TableViewAdapter
//
//  Created by Anton Ukhankin on 29.03.2020.
//  Copyright © 2020 idpuzzle1. All rights reserved.
//

import UIKit

public enum ReuseItem {
    case nib(_ nib: UINib)
    case cellClass(_ class: AnyClass)
}

public protocol UITableViewCellReusable {
    var id: String { get }
    
    func register(in tableView: UITableView)
    func reuse(cell: UITableViewCell)
}

open class TableViewCellAdapter<Model, Meta, Cell: UITableViewCell>: ViewAdapter<Model, Meta, Cell>, UITableViewCellReusable where Cell: Adaptable, Cell.Model == Model, Cell.Meta == Meta {
    public let id: String = String(describing: Model.self)
    
    public func register(in tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: self.id)
    }
    
    public func reuse(cell: UITableViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

public extension UITableView {
    func isRegistered(reusable: UITableViewCellReusable) -> Bool {
        return self.dequeueReusableCell(withIdentifier: reusable.id) != nil
    }
    
    func register(reusable: UITableViewCellReusable) {
        reusable.register(in: self)
    }
    
    func dequeueReusableCell(reusable: UITableViewCellReusable, indexPath: IndexPath) -> UITableViewCell {
        if !self.isRegistered(reusable: reusable) {
            self.register(reusable: reusable)
        }
        return self.dequeueRegisteredReusableCell(reusable: reusable, indexPath: indexPath)
    }
    
    func dequeueRegisteredReusableCell(reusable: UITableViewCellReusable, indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: reusable.id, for: indexPath)
    }
}
