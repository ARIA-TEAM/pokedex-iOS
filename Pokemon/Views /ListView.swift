//
//  ListView.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = PokemonViewModel()
    @State private var isShowingModal = false // Add a state variable to control the visibility of the modal
    @State private var selectedPokemon: Pokemon? // Add a state variable for the selected Pokemon
    @State private var isLoading = true
    @State private var showFavoritesOnly = false
    
        
    var filteredPokemons: [Pokemon] {
        var filtered = viewModel.pokemons
        
        if showFavoritesOnly {
            filtered = filtered.filter { $0.isFavorite! }
        }
        
        if !viewModel.searchText.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(viewModel.searchText.lowercased()) }
        }
        
        return filtered
    }

    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            List(filteredPokemons, id: \.name) { pokemon in
                PokemonCell(pokemon: pokemon, viewModel: viewModel)
                    .onTapGesture {
                        selectedPokemon = pokemon
                        isShowingModal = true // Show the modal
                    }
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    // Perform action for the first button
                    showFavoritesOnly = false
                }) {
                    Label(
                                    title: {
                                        Text("All")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    },
                                    icon: {
                                        Image(systemName: "list.bullet")
                                            .foregroundColor(.white)
                                    }
                                )
                }
                .buttonStyle(ActionButtonStyle())
                
                
                Button(action: {
                    // Perform action for the second button
                    showFavoritesOnly = true
                }) {
                    Label(
                                    title: {
                                        Text("Favorites")
                                            .foregroundColor(.white)
                                            .font(.headline)
                                    },
                                    icon: {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.white)
                                    }
                                )
                }
                .buttonStyle(ActionButtonStyle())
                
            }
            .padding()
            .frame(height: 50)
        }
        .navigationTitle("Pokemon List")
        .onAppear {
            viewModel.fetchData()
        }
        .sheet(item: $selectedPokemon) { pokemon in
            ModalView(pokemon: pokemon, isPresented: $isShowingModal)
        }
    }
        
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
