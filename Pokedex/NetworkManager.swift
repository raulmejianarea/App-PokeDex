//
//  NetworkManager.swift
//  Pokedex
//
//  Created by raul Mejia on 11/7/23.
//

import Foundation

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidReponse
    case invalidData
    case invalidError
    case decondingError
}


class NetworkManager{
    
    static let shared = NetworkManager()
    static let BaseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init(){
        
    }
    func getListOfPokemon(completed: @escaping (Result<[PokemonModel], APError>) -> Void)  {
        
        guard let url  = URL(string: NetworkManager.BaseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            
            guard let data = data?.paseData(removeString: "null,") else {
                completed(.failure(.decondingError))
                return
            }
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([PokemonModel].self, from: data)
                completed(.success(decodedResponse))
            }catch{
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decondingError))
            }
        }
        task.resume()
    }
}


//function to remove the null we received from the API

extension Data {
    func paseData(removeString word: String) -> Data?  {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
    }
}

struct MockData {
    static let pokemon = PokemonModel(id: 123, attack: 99, defense: 99, description: "Almost incapable of moving, this POKEMON can only fharden its shell to protect itself from predators", name: "Eve", imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2FAFC7F2B7-B889-4F56-935A-9E95E00AD65B?alt=media&token=14a27205-6033-48ad-b4ce-1154876414f7", type: "poison")
}
