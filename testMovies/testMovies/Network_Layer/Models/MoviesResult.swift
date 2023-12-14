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
    var id: Int
    var poster_path: String
    var posterFullPath: String {
    "https://www.themoviedb.org/t/p/w440_and_h660_face/" + poster_path
    }
}
