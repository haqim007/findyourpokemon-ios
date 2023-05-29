//
//  ApiService.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import Foundation

struct APIService: APIServiceProtocol{
    
    
    func fetchPokemonList(url: URL?, completion: @escaping (Result<[PokemonListItem], APIError>) -> Void) {
        guard let url  = url else {
            let errorMessage = APIError.badURL
            completion(Result.failure(errorMessage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            
            if let error = error as? URLError{
                completion(Result.failure(APIError.url(error)))
            }
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            }
            else if let data = data {
                let decoder = JSONDecoder()
                do{
                    let pokemons = try decoder.decode(PokemonList.self, from: data)
                    completion(Result.success(pokemons.results))
                }catch{
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
            
        }
        
        task.resume()
    }
    
    
    

}
