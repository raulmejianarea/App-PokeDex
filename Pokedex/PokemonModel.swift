//
//  PokemonModel.swift
//  Pokedex
//
//  Created by raul Mejia on 11/7/23.
//

import Foundation
struct PokemonModel: Codable ,Hashable {
    
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
    
}
