//
//  PokemonListItem.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 30/05/23.
//

import Foundation

// MARK: - PokemonListItem
struct PokemonListItem: Decodable, Identifiable {
    
    var id : String{
        let urlParts = url.components(separatedBy: "/")
        let itemId = urlParts[urlParts.count - 2]
        return itemId
    }
    let name: String
    let url: String
 
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
    }
    
    init(name: String, url: String){
        self.name = name
        self.url  = url
    }
}

extension PokemonListItem{
    func getImageUrl() -> String {
        let urlParts = url.components(separatedBy: "/")
        let imageId = urlParts[urlParts.count - 2]
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(imageId).png"
    }
}
