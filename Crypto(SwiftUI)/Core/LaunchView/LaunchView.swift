//
//  LaunchView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 31/07/2024.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your portfolio...".map{String($0)}
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var counter = 0
    @State var loopCount = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.launchTheme.background
                .ignoresSafeArea()
            
            VStack {
                Image("logo-transparent")
                    .resizable()
                .frame(width: 100, height: 100)
                
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(.launchAccent)
                                .opacity(counter > index ? 1 : 0)
                                .offset(y: counter == index ? -5 : 0)
                                
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
        }
        .onAppear(perform: {
            showLoadingText.toggle()
        })
        .onReceive(timer, perform: { _ in
            withAnimation(.easeIn) {
                if counter == loadingText.count {
                    counter = 0
                    loopCount += 1
                    if loopCount > 2 {
                        showLaunchView.toggle()
                    }
                }else{
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}
