//
//  Repository.swift
//  SteinsKitSample
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import Foundation

final class Repository {
    
    private let baseComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "crazism.net"
        components.path = "/steinskit"
        return components
    }()
    
}

extension Repository: RepositoryProtocol {
    
    func count(string: String, completion: @escaping (Result<Int, Error>) -> Void) {
        
        struct Response: Decodable {
            let count: Int
        }
        
        var components = baseComponents
        components.path.append("/count")
        components.queryItems = [URLQueryItem(name: "string", value: string)]
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(object.count))
                
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}
