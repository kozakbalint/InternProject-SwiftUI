//
//  MainViewModel.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    private var movies = [Movie]()
    @Published var filteredMovies: [Movie] = []
    @Published var genreFilters: Set<Genre> = []
    @Published var searchText: String = ""
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        NetworkManager.shared.getPopularMovies(page: 1)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies.map(Movie.init)
                self?.filteredMovies = self?.movies ?? []
            }
            .store(in: &cancellables)
    }
    
    func filterMovies() {
        filterByGenre()
        
        if searchText.isEmpty {
            filteredMovies = filteredMovies.isEmpty ? movies : filteredMovies
        } else {
            filteredMovies = filteredMovies.filter {
                let title = $0.title ?? ""
                return title.localizedStandardContains(searchText)
            }
        }
    }
    
    func filterByGenre() {
        if genreFilters.isEmpty {
            filteredMovies = movies
            return
        }
        
        filteredMovies = movies.filter {
            let movieGenres = Set($0.genres)
            
            return !movieGenres.intersection(self.genreFilters).isEmpty
        }
    }
}
