//
//  Adaptable.swift
//  TableViewAdapter
//
//  Created by Anton Ukhankin on 29.03.2020.
//  Copyright © 2020 idpuzzle1. All rights reserved.
//

public protocol Adaptable {
    associatedtype Model
    associatedtype Configuration
    
    func adapt(model: Model, meta: Configuration?)
}

open class ViewAdapter<Model, Configuration, View> where View: Adaptable, View.Model == Model, View.Configuration == Configuration {
    public let model: Model
    public let configuration: Configuration?
    
    public init(model: Model, meta: Configuration? = nil) {
        self.model = model
        self.configuration = meta
    }
    
    public func adapt(view: View) {
        view.adapt(model: model, meta: configuration)
    }
}
