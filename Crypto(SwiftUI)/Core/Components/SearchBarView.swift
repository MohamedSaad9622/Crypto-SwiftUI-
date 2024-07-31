//
//  SearchBarView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 19/07/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    let placholderText: String = "Search by name or sympol..."
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField(placholderText, text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .foregroundStyle(.accent)
                        .onTapGesture(perform: {
                            withAnimation {
                                UIApplication.shared.endEditing()
                                searchText = ""
                            }
                            
                        })
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.15)
                        , radius: 10)
        )
        .padding(.horizontal)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
    
}

