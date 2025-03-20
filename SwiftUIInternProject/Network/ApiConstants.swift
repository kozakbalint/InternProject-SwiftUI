//
//  ApiConstants.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation

enum Method: String {
    case get = "GET"
    case post = "POST"
}

enum Endpoint {
    case popularMovies(page: Int)
    case addRatingToMovie(id: Int)
    
    var path: String {
        switch self {
        case .popularMovies(let page):
            return "/movie/popular?page=\(page)"
        case .addRatingToMovie(let id):
            return "/movie/\(id)/rating"
        }
    }
}
