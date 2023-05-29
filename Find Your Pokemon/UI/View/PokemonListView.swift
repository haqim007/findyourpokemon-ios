//
//  ContentView.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject var viewModel = PokemonListViewModel(service: APIService())

    var body: some View {
        
        NavigationView{
            ScrollView{
                if viewModel.isLoading && viewModel.items.isEmpty{
                    LoadingView()
                }
                else if viewModel.errorMessage != nil {
                    ErrorView(viewModel: viewModel)
                }else{
                    PokemonListContent(items: $viewModel.items, performOnAppear: viewModel.fetchPokemonList)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Find Your Pokemon")
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(
            viewModel: PokemonListViewModel(
                service: APIService(),
                items: [
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/30/"),
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/13/"),
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/5/"),
                    PokemonListItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/7/")
                ]
            )
        )
    }
}

struct PokemonListContent: View{
    
    @Binding var items: [PokemonListItem]
    var performOnAppear: (_ item: PokemonListItem) -> Void
    let imageSize: CGFloat = 100
    let threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View{
        LazyVGrid(columns: threeColumnGrid){
            ForEach(items){item in


                VStack(
                    alignment: .center
                ){
                    AsyncImage(url: URL(string: item.getImageUrl())){ phase in
                        if let image = phase.image {
                                 // Displays the loaded image.
                            image.resizable()
                                .frame(width: imageSize, height: imageSize)
                                .clipped()
                        } else if phase.error != nil {
                            // Indicates an error.
                            Text("Fail to load")
                                .foregroundColor(.pink)
                                .frame(width: imageSize, height: imageSize)
                        } else {
                            ProgressView()
                                .frame(width: imageSize, height: imageSize)
                        }
                    }
                    Text(item.name)
                        .font(.headline)
                }
                    .onAppear{
                        performOnAppear(item)
                    }
                    
            }
        }
    }
}
