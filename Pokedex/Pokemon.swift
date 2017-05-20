//
//  Pokemon.swift
//  Pokedex
//
//  Created by Shengyu Cao on 5/17/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import Foundation

class Pokemon {
    
    var _pokedexID: Int!
    var _name: String!
    
    var pokedexID: Int {
        if _pokedexID == nil {
            _pokedexID = 0
        }
        return _pokedexID
    }
    
    var name : String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    
    
    
    
}
