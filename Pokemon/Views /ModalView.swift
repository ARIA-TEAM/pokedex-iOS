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
    @State private var svgContent: String?
    
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
                    
                    // Load SVG image
                    if isLoading {
                        ProgressView()
                    } else if let svgContent = svgContent {
                        SVGWebView(svgContent: svgContent)
                            .frame(width: 150, height: 150)
                    } else if let error = error {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else {
                        Color.gray
                    }
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
        }
        .onAppear {
            viewModel.fetchPokemonData(for: pokemon) { success in
                if success {
                    loadSVGContent(from: pokemonData.sprites?.other?.dream_world?.front_default)
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
    
    func loadSVGContent(from url: URL?) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.error = error
                } else if let data = data {
                    if let svgString = String(data: data, encoding: .utf8) {
                        self.svgContent = svgString
                    } else {
                        self.error = NSError(domain: "SVGConversionError", code: 0, userInfo: nil)
                    }
                }
                self.isLoading = false
            }
        }.resume()
    }
}

struct SVGWebView: UIViewRepresentable {
    let svgContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear // Set background color to clear
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlString = """
                <!DOCTYPE html>
                <html>
                <head>
                <style>
                html, body {
                    height: 100%;
                    margin: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    background-color: transparent;
                }
                
                svg {
                    max-width: 100%;
                    max-height: 100%;
                }
                </style>
                </head>
                <body>
                \(svgContent)
                </body>
                </html>
                """
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

