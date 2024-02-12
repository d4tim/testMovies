//
//  NetworkResult.swift
//  testMovies
//
//  Created by Дмитрий Тимаров on 14.12.2023.
//

import Foundation


struct MoviesResult: Codable {
    var results: [Movies]
}

struct Movies: Codable {
    var name: String
    var overview: String
    var id: Int
    var poster_path: String
    var first_air_date: String
    var posterFullPath: String {
    "https://www.themoviedb.org/t/p/w440_and_h660_face/" + poster_path
    }
    var genre_ids: [Int]
    var genres: [MovieGenres] {  return genre_ids.compactMap{ MovieGenres(rawValue: $0) }
    }
      
    
    var vote_average: Double
}
