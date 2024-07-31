//
//  CircleButtonView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

#Preview(traits: .sizeThatFitsLayout)  {
    Group {
        CircleButtonView(iconName: "info")
    }
} 
