//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import Foundation

/**
 The `PokemonViewModel` class is responsible for fetching Pokemon data from the API
 and managing the search functionality.
 */
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = [] // List of pokemons
    @Published var searchText: String = ""
    
    /**
     Initializes the `PokemonViewModel` and triggers data fetching from the API.
     */
    init() {
        fetchData()
    }
    
    /**
     Fetches Pokemon data from the API and populates the `pokemons` array.
     */
    private func fetchData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.pokemons = response.results
                }
            }
        }.resume()
    }
    
}
