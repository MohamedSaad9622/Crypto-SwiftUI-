//
//  CoinDetailDataService.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 29/07/2024.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail: CoinDetailModel? = nil
    var coinDetailSubscription: AnyCancellable?
    let coinId: String
    
    init (coinId: String){
        self.coinId = coinId
        getDetails()
    }
    
    func getDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coinId)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] coinDetail in
                self?.coinDetail = coinDetail
                self?.coinDetailSubscription?.cancel()
            })
        
    }
}
