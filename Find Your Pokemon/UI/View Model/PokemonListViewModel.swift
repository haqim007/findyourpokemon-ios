//
//  PokemonListViewModel.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import Foundation

class PokemonListViewModel: ObservableObject{
    typealias Item = PokemonListItem
    
    let service: APIServiceProtocol
    private var offset = 0
    private let limit = 30
    //Flag if all data is completely loaded
    private var isComplete = false
    
    @Published var items = [Item]()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    init(service: APIServiceProtocol, items: [Item] = [Item]()) {
        self.service = service
        self.items = items
        
        fetchPokemonList()
    }
    
    subscript(position: Int) -> Item {
        return items[position]
    }
    
    func fetchPokemonList(currentItem: Item? = nil){
        
        if !shouldLoadMore(currentItem: currentItem){
            return
        }
        
        isLoading = true
        print("isloading")
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)")
        print(url as Any)
        service.fetchPokemonList(url: url){ result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result{
                case .failure(let err):
                    self.errorMessage = err.localizedDescription
                    print(err)
                case .success(let data):
                    if !data.isEmpty{
                        self.items.append(contentsOf: data)
                        self.setNextPage()
                    }
                    self.isComplete = data.isEmpty
                    
                }
        
            }
            
        }
        
    }
    
    func setNextPage(){
        offset = items.count
    }
    
    func shouldLoadMore(currentItem: Item? = nil) -> Bool{
        
        if isComplete{
            return false
        }
        
        if isLoading {
            return false
        }
        
        guard let currentItem = currentItem else{
            return true
        }
        
        guard let lastItem = items.last else{
            return true
        }
        
        return currentItem.id == lastItem.id
    }
}
