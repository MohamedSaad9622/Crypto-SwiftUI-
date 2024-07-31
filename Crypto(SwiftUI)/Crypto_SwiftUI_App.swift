//
//  Crypto_SwiftUI_App.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 07/07/2024.
//

import SwiftUI

@main
struct Crypto_SwiftUI_App: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor : UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationStack {
                    HomeView()
                }
                .toolbar(.hidden)
                .environmentObject(vm)
                
                
                ZStack{
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2)
            }
        }
    }
}
