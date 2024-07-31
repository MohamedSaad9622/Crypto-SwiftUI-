//
//  NetworkingManager.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import Foundation
import Combine


class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL), unknown
        
        var errorDescription: String? {
            switch self {
                
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL \(url)"
            case .unknown: return "[⚠️] Unkown Error occured"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
      return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global()) //<- is default
            .receive(on: DispatchQueue.main)
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws ->  Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion( completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("done")
            break
        case .failure(let error):
            if let decodingError = error as? DecodingError {
                handleDecodingError(error: decodingError)
            } else {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private static func handleDecodingError(error: DecodingError) {
        switch error {
        case .typeMismatch(let type, let context):
            print("Type mismatch for type \(type) in \(context.codingPath): \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            print("Value not found for type \(type) in \(context.codingPath): \(context.debugDescription)")
        case .keyNotFound(let key, let context):
            print("Key '\(key.stringValue)' not found in \(context.codingPath): \(context.debugDescription)")
        case .dataCorrupted(let context):
            print("Data corrupted in \(context.codingPath): \(context.debugDescription)")
        @unknown default:
            print("Unknown decoding error: \(error.localizedDescription)")
        }
    }
    
    
}
