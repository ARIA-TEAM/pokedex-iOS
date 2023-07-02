//
//  LoadingView.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image("Loading")
                .resizable()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            
            Text("Loading...")
                .font(.headline)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
        .onAppear {
            isAnimating = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
