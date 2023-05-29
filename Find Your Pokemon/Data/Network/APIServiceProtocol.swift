//
//  ApiServiceProtocol.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import Foundation

protocol APIServiceProtocol{
    func fetchPokemonList(url: URL?, completion: @escaping(Result<[PokemonListItem], APIError>) -> Void)
}
