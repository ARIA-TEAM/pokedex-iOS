import SwiftUI
import WebKit

struct ModalView: View {
    let pokemon: Pokemon
    let types: [String] = []
    
    @StateObject private var viewModel = PokemonViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var isPresented: Bool // Binding to control the visibility of the modal
    
    @State private var isLoading = true
    @State private var error: Error?
    @State private var imageUrl: URL?
    @State private var isStarred: Bool = false
    
    var pokemonData: PokemonData {
        return viewModel.pokemonData ?? PokemonData(weight: 0.0, height: 0.0, types: [], sprites: nil)
    }
    
    var capitalizedPokemonName: String {
        let name = pokemon.name
        return name.capitalized
    }
    
    var weightInKilograms: String {
        let hectograms = pokemonData.weight
        let kilograms = hectograms * 0.1
        return String(format: "%.2f", kilograms)
    }
    
    var heightInMeters: String {
        let decimeters = pokemonData.height
        let meters = decimeters * 0.1
        return String(format: "%.2f", meters)
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
                ZStack {
                    Image("Background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 200)
                        .cornerRadius(10)
                    
                    // The pokemon image
                    ImageView(url: imageUrl)
                    
                }
                
                Divider()
                
                Text("Name: \(capitalizedPokemonName)")
                    .font(
                        Font.custom("Lato", size: 18)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                
                Divider()
                
                Text("Weight: \(weightInKilograms) kg")
                    .font(
                        Font.custom("Lato", size: 18)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                
                Divider()
                
                Text("Height: \(heightInMeters) m")
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
            
            HStack(spacing: 20) {
                Button(action: {
                    // Perform action for sharing
                    // Add your sharing logic here
                }) {
                    Text("Share with Friends")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    isStarred.toggle()
//                    if let index = viewModel.pokemons.firstIndex(of: pokemon) {
//                        viewModel.pokemons[index].isFavorite = isStarred
//                    }
                }) {
                    Image(systemName: isStarred ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isStarred ? .yellow : .gray)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                .onTapGesture {
                    isStarred.toggle()
                }
            }
        }
        .onAppear {
            viewModel.fetchPokemonData(for: pokemon) { success in
                if success {
                    self.imageUrl = URL(string: (pokemonData.sprites?.other?.officialArtwork!.frontDefault)!)
                }
            }
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

struct ImageView: View {
    
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { img in
            img
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
        } placeholder: {
            
        }
    }
}


