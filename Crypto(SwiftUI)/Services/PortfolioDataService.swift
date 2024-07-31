//
//  PortfolioDataService.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 26/07/2024.
//

import Foundation
import CoreData


class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedEntity: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: -   PUBLIC
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        //check if coin is already in portfolio
        if let entity = savedEntity.first(where: {$0.coinId == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else{
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: -   PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntity = try container.viewContext.fetch(request)
        }catch let error {
            print("Error Fetching Portfolio Entities! \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        }catch let error {
            print("Error saving to Core Data! \(error)")
        }
    }
    
    private func applyChange(){
        save()
        getPortfolio()
    }
    
}
