//
//  PortoflioView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 24/07/2024.
//

import SwiftUI

struct PortoflioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                        .padding(.bottom)
                    
                    CoinLogoList

                    if selectedCoin != nil {
                        PortfolioInputSection
                            .padding(.top)
                    }
                }
            }
            .navigationTitle("Edit Portoflio")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    DismissButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            })
            .onChange(of: vm.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
        
    }
}

#Preview {
    PortoflioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}


extension PortoflioView {
    
    private var CoinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach( vm.searchText.isEmpty ?  vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture(perform: {
                            updateSelectedCoin(coin: coin)
                        })
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id ? Color.theme.green : .clear , lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0.0)
        }
        
        return 0.0
    }
    
    private var PortfolioInputSection: some View {
        VStack(spacing: 20){
            HStack {
                Text("Current price of \(String(describing: selectedCoin?.symbol.uppercased() ?? "")):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    
            }
            
            Divider()
            
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            
        }
        .padding()
        .font(.headline)
    }
    
    
    private var saveButton: some View {
        Button(action: {
            saveButtonPressed()
        }, label: {
            HStack {
                Image(systemName: "checkmark")
                    .opacity(showCheckmark ? 1.0 : 0.0)
                Text("Save")
                    .opacity(
                        (selectedCoin != nil && selectedCoin?.currentHolds ?? 0 != Double(quantityText)) ? 1.0 : 0.0
                    )
            }
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}), let amount = portfolioCoin.currentHolds {
            quantityText = amount.asNumberString()
        }else {
            quantityText = ""
        }
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin, let amount = Double(quantityText) else {return}
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
}
