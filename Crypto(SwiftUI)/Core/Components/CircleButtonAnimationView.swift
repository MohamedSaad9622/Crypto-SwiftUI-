//
//  CircleButtonAnimationView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
       
        Circle()
            .stroke(lineWidth: 5)
            .opacity(animate ? 0.0 : 1.0)
            .scaleEffect(animate ? 1.0 : 0.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none , value: animate)
    }
}

#Preview(traits: .sizeThatFitsLayout ) {
    CircleButtonAnimationView(animate: .constant(false))
}
