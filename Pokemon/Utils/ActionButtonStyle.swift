//
//  ActionButtonStyle.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 07-07-23.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    
    var selectedOption: ListView.ButtonOption // Add selectedOption as a parameter
        
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(selectedOption == .all ? Color(red: 0.95, green: 0.15, blue: 0.22) : Color.gray) // Set background color based on the selected option
            .cornerRadius(60)
    }
}
