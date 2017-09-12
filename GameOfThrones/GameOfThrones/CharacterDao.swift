//
//  CharacterDao.swift
//  GameOfThrones
//
//  Created by Diego Eduardo on 9/12/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation
import UIKit

class CharacterDao: NSObject {
    
    public static let instance = CharacterDao()
    
    var masterCharacters = [Character]()
    
    public func parseCharacers(_ data:[[String: Any]]) {
        
        for char in data {
        
            let name = char["name"] as? String ?? ""
            let aliases = char["aliases"] as? [String] ?? []
            
            let character = Character(name: name, aliases: aliases)
            masterCharacters.append(character)
        }
    
    }
    
    public func getAllCharacters() -> [Character] {
        return masterCharacters
    }
}
