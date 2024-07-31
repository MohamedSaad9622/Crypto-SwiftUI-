//
//  HomeViewModel.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import Foundation
import Combine

enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
}

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        
//        dataService.$coins
//            .sink { [weak self] coins in
//                self?.allCoins = coins
//            }
//            .store(in: &cancellable)
        //Update all coins
        $searchText
            .combineLatest(coinDataService.$coins, $sortOption)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main) // make delay to run next code like map and sink
            .map(filterAndSortCoins)
            .sink { [weak self]  filteredCoins in
                self?.allCoins = filteredCoins
            }
            .store(in: &cancellable)
        
        //Update PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntity)
            .map(mapAllCoinsToPortfolio)
            .sink {[weak self] coins in
                guard let self = self else {return}
                self.portfolioCoins = self.sortPortfolioCoinsIfNedded(coins: coins, sort: sortOption)
            }
            .store(in: &cancellable)

        
        //Update marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellable)
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) ->  [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sort: sort)
        return updatedCoins
    }

    private func filterCoins(text: String, coins: [CoinModel]) ->   [CoinModel] {
        
        guard !text.isEmpty   else  {return coins}
        
        let lowerCaseText = text.lowercased()
        
        var filteredCoins = coins.filter { coin in
            return coin.name.lowercased() .contains(lowerCaseText) || coin.symbol.lowercased().contains(lowerCaseText) || coin.id.lowercased().contains(lowerCaseText)
        }

        return filteredCoins
    }
    
    private func sortCoins(coins: inout [CoinModel], sort: SortOption) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank})
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice})
        case .priceReversed:
            coins.sort(by: { $0.currentPrice > $1.currentPrice})
        }
    }
    
    private func mapAllCoinsToPortfolio(coinModels: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        coinModels
            .compactMap { coin in
                if let entity = portfolioEntities.first(where: { $0.coinId == coin.id }){
                    return coin.updateHoldings(amount: entity.amount)
                }else{
                    return nil
                }
            }
    }
    
    private func sortPortfolioCoinsIfNedded(coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        switch sort {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        default:
            return coins
        }
    }
    
    private func mapMarketData(market: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats = [StatisticModel]()
       
       guard let market = market else {return stats}
       
       let marketCup = StatisticModel(title: "Market Cup", value: market.marketCap, percentageChange: market.marketCapChangePercentage24HUsd)
       let volume = StatisticModel(title: "24h Volume", value: market.volume)
       let btcDominance = StatisticModel(title: "BTC Dominance", value: market.btcDominance)
        
        let portfolioValue =
            portfolioCoins
                .map({$0.currentHoldingValue})
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map({ (coin) -> Double in
                let currentValue = coin.currentHoldingValue
                let percentageChange = (coin.priceChangePercentage24H ?? 0.0) / 100
                let previousValue = currentValue / ( percentageChange + 1)
                return previousValue
            })
            .reduce(0, +)
        
        let percentageChange = (portfolioValue - previousValue) / previousValue  * 100
        let portofolio = StatisticModel(title: "Portofolio", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
       
       stats.append(contentsOf: [
           marketCup, volume, btcDominance, portofolio
       ])
       return stats
    }
    
    
    
}
