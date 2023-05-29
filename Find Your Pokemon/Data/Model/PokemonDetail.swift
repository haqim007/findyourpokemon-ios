//
//  PokemonDetail.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 30/05/23.
//

import Foundation


// MARK: - PokemonDetail
struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let moves: [PokemonDetailMove]
    let name: String
    let types: [PokemonDetailType]

    enum CodingKeys: String, CodingKey{
        case id
        case moves
        case name
        case types
    }
}


// MARK: - Pokemon Detail Move
struct PokemonDetailMove: Decodable {
    let move: PokemonDetailBaseData
}

// MARK: - Pokemon Detail Type
struct PokemonDetailType: Decodable {
    let type: PokemonDetailBaseData
}

// MARK: - Pokemon Detail Base Data
struct PokemonDetailBaseData: Decodable{
    let name: String
    let url: String
}
