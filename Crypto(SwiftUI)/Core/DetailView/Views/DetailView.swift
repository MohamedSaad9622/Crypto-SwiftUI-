//
//  DetailView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 28/07/2024.
//

import SwiftUI

struct DetailView: View {
    
    
    @StateObject var vm: DetailViewModel
    @State var showFullDescription = false
    
    
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {
                ChartView(coin: vm.coin)
                
                VStack{
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    webssiteSection
                    
                }//Vstack
                .padding()
                
            }// Vstack
            
        }// ScrollView
        .navigationTitle(vm.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationItem
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailView {
    
    private var navigationItem: some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.secondaryText)
            
            CoinImage(imageURL: vm.coin.image)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional details")
            .font(.title)
            .bold()
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading , content: {
            ForEach(vm.overviewStatistic) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, content: {
            ForEach(vm.additionalStatistic) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var descriptionSection: some View {
        ZStack{
            if let description = vm.coinDescription, !description.isEmpty {
                VStack(alignment: .leading){
                    Text(description)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(.secondaryText)
                    
                    Button {
                        withAnimation {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                    
                }
            }
        }
    }
    
    private var webssiteSection: some View {
        VStack(spacing: 10){
            if let websiteString = vm.websiteURL, let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if let redditString = vm.redditURL, let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
        }
        .font(.headline)
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
