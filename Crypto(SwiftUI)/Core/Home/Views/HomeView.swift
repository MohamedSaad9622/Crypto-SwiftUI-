//
//  HomeView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var showPortfolio: Bool = true
    @State private var showPortfolioView: Bool = false
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortoflioView()
                        .environmentObject(vm)
                })
            
            //content layer
            VStack(spacing: 5){
                
                homeHeader
                
                HomeStatsView(showPortoflio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
            
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                    
                }else{
                    protfolioCoinsList
                        .transition(.move(edge: .trailing))
                        
                }
                
                Spacer(minLength: 0)//to push to top but still in safeArea
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
    .toolbar(.hidden)
    
}

extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture(perform: {
                    showPortfolioView = showPortfolio
                })
            
            Spacer()
            
            Text(showPortfolio ? "Protfolio" : "Live Prices")
                .animation(.none, value: showPortfolio)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal )
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
        .refreshable {
            vm.reloadData()
        }
    }
    
    
    private var protfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
        .refreshable {
            vm.reloadData()
        }
    }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180 ))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0 )
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180 ))
                }
                .onTapGesture {
                    withAnimation {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180 ))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(.degrees(vm.isLoading ? 360 : 0), anchor: .center)

        }
        .foregroundStyle(.secondaryText)
        .font(.caption)
        .padding(.horizontal)
        .padding(.top, 5)
    }
    
}
