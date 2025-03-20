//
//  MoviesResponse.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation

struct MoviesResponse: Decodable {
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int
}
