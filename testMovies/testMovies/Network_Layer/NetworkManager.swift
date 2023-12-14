//
//  NetworkManager.swift
//  testMovies
//
//  Created by Дмитрий Тимаров on 14.12.2023.
//


//
//  NetworkManager.swift
//  testNetworking
//
//  Created by Дмитрий Тимаров on 14.12.2023.
//

import Foundation

class NetworkManager {
    
    
    static let shared = NetworkManager()
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared ) {
        self.session = session
    }
    
    
    private func setTimeOut(_ seconds: Double , completion: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    
    func call(with request: URLRequest, completion: @escaping(Result<Data, Error>) -> () ) {
        
        
        let task = session.dataTask(with: request) { data, response, error in
            
            
            if error == nil {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(NetworkError.noData))
                }
               
            } else {
                completion(.failure(NetworkError.connectionFailure))
            }
            
        } .resume()
        
    }
    
}

enum NetworkError: Error {
    case timedOut
    case connectionFailure
    case noData
    case InvalidUrl
}


