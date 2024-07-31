//
//  DetailViewModel.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 29/07/2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistic = [StatisticModel]()
    @Published var additionalStatistic = [StatisticModel]()
    @Published var coinDetail: CoinDetailModel? = nil
    @Published var coin: CoinModel
    @Published var coinDescription: String? = nil
    @Published var redditURL: String? = nil
    @Published var websiteURL: String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancellabel = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coinId: coin.id)
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map(mapDataStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistic = returnedArrays.overviewStatistic
                self?.additionalStatistic = returnedArrays.additionalStatistic
            }
            .store(in: &cancellabel)
        
        coinDetailService.$coinDetail
            .sink { [weak self] coin in
                self?.coinDescription = coin?.readableDescription
                self?.websiteURL = coin?.links?.homepage?.first
                self?.redditURL = coin?.links?.subredditURL
            }
            .store(in: &cancellabel)
    }
    
    private func mapDataStatistics(coinDetail: CoinDetailModel?, coin: CoinModel) -> (overviewStatistic: [StatisticModel], additionalStatistic: [StatisticModel]) {
        return (createOverviewStat(coin: coin), createAdditionalStat(coinDetail: coinDetail, coin: coin))
    }
    
    private func createOverviewStat(coin: CoinModel) -> [StatisticModel] {
        
        let price = coin.currentPrice.asCurrencyWith2Decimals()
        let pricePercentChange = coin.priceChange24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Captalization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overview : [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        return overview
    }
    
    private func createAdditionalStat(coinDetail: CoinDetailModel?, coin: CoinModel) -> [StatisticModel] {
        
        let high = coin.high24H?.asCurrencyWith2Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyWith2Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
            
        let priceChange = coin.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)

        let additional: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        return additional
    }
    
}
