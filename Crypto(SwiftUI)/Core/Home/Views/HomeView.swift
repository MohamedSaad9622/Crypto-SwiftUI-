//
//  HomeView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProtfolio: Bool = false
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                
                homeHeader
                
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

extension HomeView {
    var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .animation(.none, value: showProtfolio)
                .background(
                    CircleButtonAnimationView(animate: $showProtfolio)
                )
            
            Spacer()
            
            Text(showProtfolio ? "Protfolio" : "Live Prices")
                .animation(.none, value: showProtfolio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showProtfolio.toggle()
                    }
                }
            
        }
        .padding()
    }
}
