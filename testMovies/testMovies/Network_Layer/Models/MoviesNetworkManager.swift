//
//  MoviesNetworkManager.swift
//  testMovies
//
//  Created by Makar Grushka on 12.01.2024.
//

import Foundation
import UIKit

class MoviesNetworkManager {
    func fetchNowPlayingMovies(completion: @escaping(Result<MoviesResult, Error>) -> ())  {
        guard  let url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=55957fcf3ba81b137f8fc01ac5a31fb5") else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        NetworkManager.shared.call(with: urlRequest) { res in
            switch res {
                
            case let .success(data):
                let decoder = JSONDecoder()

                if let resultMovies = try? decoder.decode(MoviesResult.self, from: data) {
                    completion(.success(resultMovies))
//                    petitions = jsonPetitions.results
                    
                }
                print(data)
            case let .failure(error):
                print(error)
            }
        }
        
    }
}
