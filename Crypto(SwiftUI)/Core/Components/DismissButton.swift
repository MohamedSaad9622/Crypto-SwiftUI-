//
//  DismissButton.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 24/07/2024.
//

import SwiftUI

struct DismissButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    DismissButton()
}
