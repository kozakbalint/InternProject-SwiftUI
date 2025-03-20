//
//  RatingViewModel.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Combine
import Foundation
import TmdbNetworkManager

final class RatingViewModel: ObservableObject {
    @Published var rating: Int = 0
    @Published var success: Bool = false
    private var movieId: Int
    private var cancellables: Set<AnyCancellable> = []
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func sendRating(rating: Int) {
        NetworkManager.shared.addRatingToMovie(movieId: movieId, value: Double(rating))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] response in
                if response.success {
                    self?.success = true
                }
            }
            .store(in: &cancellables)
    }
}
