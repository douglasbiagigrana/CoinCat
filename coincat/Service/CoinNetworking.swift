//
//  CoinService.swift
//  coincat
//
//  Created by Douglas Biagi Grana on 08/04/22.
//

import Foundation

enum ResultError: Error {
    case badURL, noData, invalidaJSON
}

class CoinNetworking {
    struct Constants {
        static let cgURL = URL(string: "https://api.coingecko.com/api/v3/coins/list")
    }
    
    func coinRequest(completion: @escaping (Result<[Coin], ResultError>) -> Void) {
        guard let url = Constants.cgURL else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                completion(.failure(.invalidaJSON))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([Coin].self, from: data)
                completion(.success(result))
            } catch {
                print("(COIN NETWORKING error coinrequest -> \(error)")
                completion(.failure(.noData))
            }

        }
        task.resume()
    }
}
