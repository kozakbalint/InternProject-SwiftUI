//
//  NetworkManager.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Combine
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let tmdbApiClient: TmdbApiClient
    
    
    private init() {
        guard let plistFile = Bundle.main.path(forResource: "Tmdb", ofType: "plist") else {
            fatalError("No Tmdb.plist file found")
        }
        
        let plist = NSDictionary(contentsOfFile: plistFile)
        
        guard let apiKey = plist?["TMDB_AUTH_TOKEN"] as? String else {
            fatalError("No TMDB_AUTH_TOKEN found in Tmdb.plist")
        }
        
        self.tmdbApiClient = TmdbApiClient(authToken: apiKey)
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResponse], Error> {
        return Future<[MovieResponse], Error> { promise in
            Task {
                let result = await self.tmdbApiClient.get(endpoint: .popularMovies(page: page), responseType: MoviesResponse.self)
                switch result {
                case .success(let movies):
                    promise(.success(movies.results))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
        
    func addRatingToMovie(movieId: Int, value: Double) -> AnyPublisher<RatingResponse, Error> {
        return Future<RatingResponse, Error> { promise in
            Task {
                let requestBody = RatingRequest(value: value)
                let result = await self.tmdbApiClient.post(endpoint: .addRatingToMovie(id: movieId), requestBody: requestBody, responseType: RatingResponse.self)
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
