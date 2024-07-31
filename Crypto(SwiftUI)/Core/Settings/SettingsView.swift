//
//  SettingsView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 30/07/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                swiftfulThinkingSection
                
                coinGeckoSection
            }
            .font(.headline)
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButton()
                }
            })
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following @SwiftfulThinking coures on youtube, it use MVVM Architecture, combine and CoreData")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Subscripe on youtube 🥳", destination: URL(string: "https://www.youtube.com/@SwiftfulThinking")!)
                .foregroundStyle(.blue)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes form a free API from CoinGecko! prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit CoinGecko 🥳", destination: URL(string: "https://www.coingecko.com/en/api")!)
                .foregroundStyle(.blue)
        } header: {
            Text("CoinGecko")
        }
    }
}
