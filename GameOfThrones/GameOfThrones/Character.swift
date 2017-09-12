//
//  Character.swift
//  GameOfThrones
//
//  Created by Diego Eduardo on 9/12/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

class Character: NSObject {
    
    public var name: String
    public var aliases: [String]
    
    public init(name: String, aliases: [String]) {
        
        self.name = name
        self.aliases = aliases
    }
    
    public func displayName() -> String {
        
        var result = self.name
        if let firstAlias = self.aliases.first {
            if !(firstAlias.isEmpty) {
                result += " \"\(firstAlias)\""
            }
        }
        return result
    }
}
