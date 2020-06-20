//
//  Adaptable.swift
//  TableViewAdapter
//
//  Created by Anton Ukhankin on 29.03.2020.
//  Copyright © 2020 idpuzzle1. All rights reserved.
//

public protocol Adaptable {
    associatedtype Model
    associatedtype Meta
    
    func adapt(model: Model, meta: Meta?)
}

open class ViewAdapter<Model, Meta, View> where View: Adaptable, View.Model == Model, View.Meta == Meta {
    public let model: Model
    public let meta: Meta?
    
    public init(model: Model, meta: Meta? = nil) {
        self.model = model
        self.meta = meta
    }
    
    public func adapt(view: View) {
        view.adapt(model: model, meta: meta)
    }
}
