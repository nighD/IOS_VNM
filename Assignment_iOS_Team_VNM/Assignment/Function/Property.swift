//
//  PropertyReflect.swift
//  Assignment
//
//  Created by Cooldown on 26/9/18.
//  Copyright © 2018 Cooldown. All rights reserved.
//

import Foundation
protocol Property{
    typealias RepresentationType = [String:Any]
    typealias ValuesType = [Any]
    typealias NamesType = [String]
    var propertyDictRepresentation: RepresentationType {get}
    var propertyValues: ValuesType {get}
    var propertyNames: NamesType {get}
    static var propertyCount: Int {get}
    //construction from representation type
    init(_ r:RepresentationType)
}


//default implementation
extension Property{
    
    var propertyDictRepresentation: RepresentationType {
        var ret: [String:Any] = [:]
        for case let (label, value) in Mirror(reflecting: self).children {
            guard let l = label else{
                continue
            }
            ret.updateValue(value, forKey: l)
        }
        return ret
    }
    
    var propertyValues: ValuesType {
        return Array(propertyDictRepresentation.values)
    }
    
    var propertyNames: NamesType {
        return Array(propertyDictRepresentation.keys)
    }
}
