//
//  ViewController.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 04/10/2020.
//  Copyright (c) 2020 Anton Ukhankin. All rights reserved.
//

import UIKit
import Adaptable

class TextTableViewCell: UITableViewCell, Adaptable {
    typealias Model = String
    typealias Configuration = [NSAttributedString.Key: Any]
    
    func adapt(model: Model, meta: Configuration?) {
        self.textLabel?.attributedText = type(of: self).attributedString(model: model, meta: meta)
    }
    
    private class func attributedString(model: Model, meta: Configuration?) -> NSAttributedString? {
        return NSAttributedString(string: model, attributes: meta)
    }
}

class TableDataSource: NSObject {
    typealias TitleTableAdapter = TableViewCellAdapter<String, [NSAttributedString.Key: Any], TextTableViewCell>
    
    let tableView: UITableView
    var adapters: [UITableViewCellReusable]
    
    init(tableView: UITableView) {
        self.tableView = tableView
                        
        self.adapters = ["first", "second"].compactMap { item -> UITableViewCellReusable? in
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .heavy), .foregroundColor: UIColor.gray]
            return TitleTableAdapter(model: item, meta: attributes)
        }
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
}

extension TableDataSource: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let adapter = self.adapters[indexPath.row]
        let cell = tableView.dequeueReusableCell(reusable: adapter, indexPath: indexPath)
        adapter.reuse(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class ViewController: UITableViewController {
    private var dataSource: TableDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = TableDataSource(tableView: self.tableView)
        // Do any additional setup after loading the view.
    }
}

