//
//  TableViewAdaptable.swift
//  TableViewAdapter
//
//  Created by Anton Ukhankin on 29.03.2020.
//  Copyright © 2020 idpuzzle1. All rights reserved.
//

import UIKit

public protocol UITableViewCellReusable: CollectionIdentifiable {    
    func register(in tableView: UITableView)
    func reuse(cell: UITableViewCell)
}

open class TableViewNibCellAdapter<Model, Configuration, Cell: UITableViewCell>: ViewAdapter<Model, Configuration, Cell> where Cell: Adaptable, Cell.Model == Model, Cell.Configuration == Configuration {
    private(set) var nib: UINib = UINib(nibName: String(describing: Cell.self), bundle: nil)
    
    convenience init(model: Model, configuration: Configuration, nib: UINib) {
        self.init(model: model, configuration: configuration)
        self.nib = nib
    }
    
}

extension TableViewNibCellAdapter: UITableViewCellReusable {
    public var id: String {
        return String(describing: Model.self)
    }
    
    public func register(in tableView: UITableView) {
            tableView.register(nib, forCellReuseIdentifier: self.id)
    }
    
    public func reuse(cell: UITableViewCell) {
        guard let adaptedCell = cell as? Cell else {
            return
        }
        self.adapt(view: adaptedCell)
    }
}

open class TableViewCellAdapter<Model, Configuration, Cell: UITableViewCell>: ViewAdapter<Model, Configuration, Cell> where Cell: Adaptable, Cell.Model == Model, Cell.Configuration == Configuration {
}

extension TableViewCellAdapter: UITableViewCellReusable {
    public var id: String {
        return String(describing: Model.self)
    }
    
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
    func register(reusable: UITableViewCellReusable) {
        reusable.register(in: self)
    }
        
    func dequeueReusableCell(reusable: UITableViewCellReusable, indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: reusable.id, for: indexPath)
        reusable.reuse(cell: cell)
        return cell
    }
}
