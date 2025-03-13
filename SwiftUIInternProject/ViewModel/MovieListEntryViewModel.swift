//
//  MovieListEntryViewModel.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 13..
//

import Foundation

class MovieListEntryViewModel: ObservableObject {
    @Published var title: String
    @Published var releaseYear: String
    @Published var posterUrl: URL?
    
    let cellHeight: CGFloat = 120
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.releaseYear = movie.releaseYear ?? ""
        self.posterUrl = movie.posterURL
    }
}
