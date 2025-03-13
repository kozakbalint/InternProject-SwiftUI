//
//  DetailViewModel.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 13..
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var isSheetPresented: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
    }
}
