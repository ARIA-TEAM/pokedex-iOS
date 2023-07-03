//
//  ModalView.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 02-07-23.
//

import SwiftUI

struct ModalView: View {
    let pokemon: Pokemon
    let types: [String] = []
    @StateObject private var viewModel = PokemonViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool // Binding to control the visibility of the modal
    var pokemonData: PokemonData {
        return viewModel.pokemonData ?? PokemonData(weight: 0.0, height: 0.0, types: [])
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .padding()
            }
            
            VStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: "https://www.pngmart.com/files/22/Bulbasaur-Pokemon-Download-PNG-Isolated-Image.png")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 200)
                } placeholder: {
                    Color.gray
                        .frame(width: 500, height: 200)
                }

                Divider()
                
                Text("Name: \(pokemon.name)")
                  .font(
                    Font.custom("Lato", size: 18)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                
                Divider()
                
                Text("Weight: \(pokemonData.weight)")
                  .font(
                    Font.custom("Lato", size: 18)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                
                Divider()
                
                Text("Height: \(pokemonData.height)")
                  .font(
                    Font.custom("Lato", size: 18)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                
                Divider()
                
                Text("Types: \(getAllTypes(data: pokemonData))")
                  .font(
                    Font.custom("Lato", size: 18)
                      .weight(.bold)
                  )
                  .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
            }
            .padding()
            
            Spacer()
        }
        .onAppear{
            viewModel.fetchPokemonData(for: pokemon)
        }
    }
    
    func getAllTypes(data: PokemonData) -> String {
        if let types = data.types {
            let typeNames = types.map { $0.type.name }
            let joinedNames = typeNames.joined(separator: ", ")
            
            return joinedNames
        }
        return ""
    }
    
}

