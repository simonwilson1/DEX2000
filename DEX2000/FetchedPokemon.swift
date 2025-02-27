//
//  FetchedPokemon.swift
//  DEX2000
//
//  Created by Simon Wilson on 25/02/2025.
//

import Foundation

struct FetchedPokemon: Decodable {
    
    let id: Int16
    let name: String
    let types: [String]
    let hp: Int16
    let attack: Int16
    let defense: Int16
    let specialAttack: Int16
    let specialDefense: Int16
    let speed: Int16
    let sprite: URL
    let shiny: URL
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: CodingKey {
            case type
            
            enum TypeKeys: CodingKey {
                case name
            }
        }
        
        enum StatDictionaryKeys: CodingKey {
            case baseStat
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "frontDefault"
            case shiny = "frontShiny"
        }
       
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        id = try container.decode(Int16.self, forKey: .id)
        
        name = try container.decode(String.self, forKey: .name)
        
        var decodedTypes: [String] = []
        
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        while !typesContainer.isAtEnd {
            // decode types
            let typesDictionaryContainer = try typesContainer.nestedContainer(keyedBy: CodingKeys.TypeDictionaryKeys.self)
            
            let typeContainer = try typesDictionaryContainer.nestedContainer(keyedBy: CodingKeys.TypeDictionaryKeys.TypeKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            
            decodedTypes.append(type)
        }
        // Pidgeot: ["Normal", "Flying"]
        if decodedTypes.count == 2 && decodedTypes[0] == "normal" {
            decodedTypes.swapAt(0, 1)
            
        }
        types = decodedTypes
        
        var decodedStats: [Int16] = []
        var statsContainer = try container .nestedUnkeyedContainer(forKey: .stats)
        
        while !statsContainer.isAtEnd {
            
            let statsDictionaryContainer = try statsContainer.nestedContainer(keyedBy: CodingKeys.StatDictionaryKeys.self)
            
            let stat = try statsDictionaryContainer.decode(Int16.self, forKey: .baseStat)
            
            decodedStats.append(stat)
            
        }
        hp = decodedStats[0]
        attack = decodedStats[1]
        defense = decodedStats[2]
        specialAttack = decodedStats[3]
        specialDefense = decodedStats[4]
        speed = decodedStats[5]
        
        let spriteContainer = try container.nestedContainer(keyedBy: CodingKeys.SpriteKeys.self, forKey: .sprites)
        
        sprite = try spriteContainer.decode(URL.self, forKey: .sprite)
        shiny = try spriteContainer.decode(URL.self, forKey: .shiny)
    }
}
