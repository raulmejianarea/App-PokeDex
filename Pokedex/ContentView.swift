//
//  ContentView.swift
//  Pokedex
//
//  Created by raul Mejia on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PokemonViewModel()
    @State private var pokemonToSearch = ""
    
    private let  numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),

    ]
    
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: numberOfColumns) {
                    ForEach(viewModel.filteredPokemon, id: \.self) {
                        pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonCellView(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                }.padding(20)
            }//Scroll
            .searchable(text: $pokemonToSearch, prompt: "Search pokemon")
            .onChange(of: pokemonToSearch , perform: { newValue in
                withAnimation {
                    viewModel.filterPokemon(name: newValue)
                }
            })
            .navigationBarTitle("PokeDex", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
