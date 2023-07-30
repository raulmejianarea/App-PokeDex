//
//  pokemonCellView.swift
//  Pokedex
//
//  Created by raul Mejia on 12/7/23.
//

import SwiftUI

struct PokemonCellView: View {
    
    let pokemon: PokemonModel
    let viewModel: PokemonViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(viewModel.getColorBasedOnType(type: pokemon.type))
                .cornerRadius(25)
                
                              VStack{
                    AsyncImage(url: URL(string: pokemon.imageUrl)){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                        
                    }   placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .shadow(radius: 12)
                                  Text(pokemon.name)
                                      .font(.body)
                                      .foregroundColor(.white)
                    
                }
                
        }
    }
}



