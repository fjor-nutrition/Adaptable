//
//  TableViewAdaptable.swift
//  TableViewAdapter
//
//  Created by Anton Ukhankin on 29.03.2020.
//  Copyright © 2020 idpuzzle1. All rights reserved.
//

import UIKit

open class TableViewCellAdapter<Cell: UITableViewCell>: ViewAdapter<Cell.Model, Cell.Configuration, Cell> where Cell: Adaptable {
    typealias Model = Cell.Model
    typealias Configuration = Cell.Configuration
}

extension TableViewCellAdapter: UITableViewCellReusable {
    public var reuseIdentifier: String {
        return String(describing: Cell.self) + " - " + String(describing: Model.self)
    }
        
    public func reuse(cell: UITableViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

extension TableViewCellAdapter where Cell: CollectionRegistrable {
    public func register(in tableView: UITableView) {
        tableView.register(Cell.self, id: self.reuseIdentifier)
    }
}
