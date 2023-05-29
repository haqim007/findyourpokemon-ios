//
//  PokemonList.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import Foundation


// MARK: - PokemonList
struct PokemonList: Decodable {
    
    
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
    
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        next = try? container.decode(String.self, forKey: .next)
        previous = try? container.decode(String.self, forKey: .previous)
        results = try container.decode([PokemonListItem].self, forKey: .results)
    }
}

