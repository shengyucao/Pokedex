//
//  Pokemon.swift
//  Pokedex
//
//  Created by Shengyu Cao on 5/17/17.
//  Copyright © 2017 Shengyu Cao. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _pokedexID: Int!
    private var _name: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _defense: String!
    private var _detailInfo: String!
    private var _evoLbl: String!
    private var _nextEvoId: String!
    private var _pokemonURL: String!
    
    
    
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
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var height : String {
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight : String {
        if _weight == nil{
            _weight = nil
        }
        return _weight
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var evoLbl: String {
        if _evoLbl == nil {
            _evoLbl = ""
        }
        return _evoLbl
    }
    
    var detailInfo: String {
        if _detailInfo == nil{
            _detailInfo = ""
        }
        return _detailInfo
    }
    
    var nextEvoId:String {
        if _nextEvoId == nil{
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(BASE_POKEMON_URL)\(self.pokedexID)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete){
        Alamofire.request(self._pokemonURL!).responseJSON{ (response) in

            if let JSON = response.result.value as? [String: Any]{
                if let height = JSON["height"] as? String {
                    self._height = height
                    print(self._height)
                }
                if let weight = JSON["weight"] as? String {
                    self._weight = weight
                    print(self._weight)
                }
                if let attack = JSON["attack"] as? Int {
                    self._attack = "\(attack)"
                    print(self._attack)
                }
                if let defense = JSON["defense"] as? Int {
                    self._defense = "\(defense)"
                    print(self._defense)
                }
                if let types = JSON["types"] as? [[String:Any]]{
                    var typeArray = ""
                    if let name = types[0]["name"] as? String{
                        typeArray.append(name)
                    }
                    if types.count > 1 {
                    
                        for i in 1..<types.count {
                            if let name = types[i]["name"] as? String{
                                typeArray.append("/\(name)")
                            }
                        }
                    }
                    self._type = typeArray
                    print(self._type)
                }
                if let descriptions = JSON["descriptions"] as? [[String:Any]]{
                    if let resource_uri = descriptions[0]["resource_uri"] {
                        let resourceURL = "\(API_URL)\(resource_uri)"
                        Alamofire.request(resourceURL).responseJSON { (response) in
                            
                            if let resourceJSON = response.result.value as? [String:Any] {
                                if let description = resourceJSON["description"] as? String {
                                    self._detailInfo = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    print (self._detailInfo)
                                }
                            }
                            completed()
                        }
                        
                    }
                }
                
                if let evolutions = JSON["evolutions"] as? [[String: Any]] , evolutions.count != 0 {
                    if let level = evolutions[0]["level"] as? Int, let evoTo = evolutions[0]["to"] as? String {
                        self._evoLbl = "Next Evolution: \(evoTo) at LVL \(level)"
                        print(self._evoLbl)
                        
                    } else {
                        self._evoLbl = "No Evolution!"
                        print(self._evoLbl)
                    }
                    
                    if let uri = evolutions[0]["resource_uri"] as? String {
                    
                        let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let newStr2 = newStr.replacingOccurrences(of: "/", with: "")
                        self._nextEvoId = newStr2
                    
                    }
                    
                    
                } else {
                    self._evoLbl = "No Evolution!"
                    print(self._evoLbl)
                }
            }
        
            completed()
        }
        
    }
}
