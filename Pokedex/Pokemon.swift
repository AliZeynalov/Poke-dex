//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ali Zeynalov on 02/09/16.
//  Copyright © 2016 Ali Zeynalov. All rights reserved.
//



import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    var description: String
    {
        if self._description==nil
        {
            self._description=""
        }
        return self._description
    }
    
    
    
    var type: String
    {
        if self._type==nil
        {
            self._type=""
        }
        return self._type
    }
    
    
    
    var defense: String
    {
        if self._defense==nil
        {
            self._defense=""
        }
        return self._defense
    }
    
    
    var height: String
    {
        if self._height==nil
        {
            self._height=""
        }
        return self._height
    }
    
    
    var weight: String
    {
        if self._weight==nil
        {
            self._weight=""
        }
        return self._weight
    }
    
    
    var attack: String
    {
        if self._attack==nil
        {
            self._attack=""
        }
        return self._attack
    }
    
    
    var nextEvolutionTxt: String
    {
        if self._nextEvolutionTxt==nil
        {
            self._nextEvolutionTxt=""
        }
        return self._nextEvolutionTxt
    }
    
    
    var nextEvolutionId: String
    {
        if self._nextEvolutionId==nil
        {
            self._nextEvolutionId=""
        }
        return self._nextEvolutionId
    }
    
    
    var nextEvolutionLvl: String
    {
        if self._nextEvolutionLvl==nil
        {
            self._nextEvolutionLvl=""
        }
        return self._nextEvolutionLvl
    }
    
    
    var name: String
    {
        return _name
    }
    
    
    var pokedexId: Int
    {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl="\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete)
    {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            
            
            
                ///datanın alınması, kontrol edilmesi, weight,height, defence, attack'ın parse edilip yerleştirilmesi
                if let dict=result.value as? Dictionary<String,AnyObject>
                {
                    if let weight=dict["weight"] as? String
                    {
                        self._weight=weight
                    }
                    
                    if let height=dict["height"] as? String
                    {
                        self._height=height
                    }
                    
                    if let attack=dict["attack"] as? Int
                    {
                        self._attack="\(attack)"
                    }
                    
                    if let defense=dict["defense"] as? Int
                    {
                        self._defense="\(defense)"
                    }
                    
                    print(self._weight)
                    print(self._height)
                    print(self._defense)
                    print(self._attack)
                    
                    
                    
                    
                    //////type'ların parse edilmesi, yerleşdirilmesi
                    if let types=dict["types"] as? [Dictionary<String,String>] where types.count>0
                    {
                        if let name = types[0]["name"]
                        {
                            self._type=name
                        }
                        
                        if types.count>1
                        {
                            for var x=1; x<types.count; x++
                            {
                                if let name = types[x]["name"]
                                {
                                    self._type! += "/ \(name)"
                                }
                            }
                        }
                        print("\(self._type) type")
                        
                    }
                    
                    
                    ////Description'ın parse edilmesi
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count>0
                    {
                        if let url = descArr[0]["resource_uri"]
                        {   let nsurl=NSURL(string: "\(URL_BASE)\(url)")
                            Alamofire.request(.GET, nsurl!).responseJSON{
                                response in let desResult = response.result
                                if let descDict=desResult.value as? Dictionary<String,AnyObject>
                                {
                                    if let description=descDict["description"] as? String
                                    {
                                        self._description=description
                                        print("\(self._description) description")
                                    }
                                }
                                completed()
                            }
                        }
                    }
                    else
                    {
                        self._description=""
                    }
                    

                    
                    
                    ////Evolution Parsing
                    if let evolutions=dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count>0
                    {
                        if let to=evolutions[0]["to"] as? String
                        {
                            //Mega olan pokemonlari handle edemedigimiz icin filtre ediyoruz
                            if to.rangeOfString("mega") == nil
                            {
                                if let uri=evolutions[0]["resource_uri"] as? String
                                {
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    self._nextEvolutionId=num
                                    self._nextEvolutionTxt=to
                                    
                                    //////evolution leveli parse edilerek yerlestiriliyor
                                    if let lvl=evolutions[0]["level"] as? Int
                                    {
                                        self._nextEvolutionLvl="\(lvl)"
                                    }
                                                                    }
                            }
                            
                        }
                        print(self._nextEvolutionId)
                        print(self._nextEvolutionTxt)
                        print(self._nextEvolutionLvl)
                    }

                }
            
            }
        }
    




}







