//
//  HomeView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                Text("Header")
                Spacer(minLength: 0)//to push to top but still in safeArea
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
//            .navigationBarHi
    }
    
}
