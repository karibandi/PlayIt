//
//  NetworkManager.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import Foundation
import Foundation
class NetworkManager<T: Codable> {

    func fetch(url:URL, completion: @escaping (Result<T?, NetworkError>) -> Void)  {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{
                completion(.failure(.emptyData))
                return
            }
            let decoder = JSONDecoder()
            do{
                let responseData = try decoder.decode(T.self, from: data)
                completion(.success(responseData))
            }catch{
                completion(.failure(.failed(error: error)))
            }
        }.resume()
    }
}
