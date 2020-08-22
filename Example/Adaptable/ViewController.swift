//
//  ViewController.swift
//  Adaptable
//
//  Created by Anton Ukhankin on 04/10/2020.
//  Copyright (c) 2020 Anton Ukhankin. All rights reserved.
//

import UIKit
import Adaptable

class TextTableViewCell: UITableViewCell, Adaptable, CollectionRegistrable {
    typealias Model = String
    typealias Configuration = [NSAttributedString.Key: Any]?
    static let registrator: Registrator = .anyClass(TextTableViewCell.self)
    
    func adapt(model: Model, configuration: Configuration) {
        self.textLabel?.attributedText = type(of: self).attributedString(model: model, configuration: configuration)
    }
    
    private class func attributedString(model: Model, configuration: Configuration) -> NSAttributedString? {
        return NSAttributedString(string: model, attributes: configuration)
    }
}

class TableDataSource: NSObject {
    typealias TitleTableAdapter = TableViewCellAdapter<String, [NSAttributedString.Key: Any]?, TextTableViewCell>
    
    let tableView: UITableView
    var reusingCellItems: [UITableViewCellReusable]
    
    init(tableView: UITableView) {
        self.tableView = tableView
                       
        let titleItems: [TitleTableAdapter] = ["first", "second"].compactMap { item in
            let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .heavy), .foregroundColor: UIColor.gray]
            return TitleTableAdapter(model: item, configuration: attributes)
        }
        self.reusingCellItems = titleItems
        super.init()
        
        titleItems.forEach {
            $0.register(in: tableView)
        }
        
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
        return reusingCellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableItem = self.reusingCellItems[indexPath.row]
        return tableView.dequeueReusableCell(reusable: reusableItem, indexPath: indexPath)
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

