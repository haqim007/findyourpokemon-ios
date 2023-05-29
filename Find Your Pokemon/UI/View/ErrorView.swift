//
//  ErrorView.swift
//  Find Your Pokemon
//
//  Created by Haqim007 on 29/05/23.
//

import SwiftUI

struct ErrorView: View {
    @StateObject var viewModel: PokemonListViewModel
    
    
    var body: some View {
        VStack{
            Text("🙀")
                .font(.system(size: 80))
            Text(viewModel.errorMessage ?? "Error")
                .font(.system(size: 15))
                .padding()
            Button{
                viewModel.fetchPokemonList()
            }label: {
                Text("Try Again")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            viewModel: PokemonListViewModel(
                service: APIService()
            )
        )
    }
}
