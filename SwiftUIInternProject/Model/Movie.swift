//
//  Movie.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Foundation

struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genres: [Genre]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL: URL? {
        if let posterPath = posterPath, !posterPath.isEmpty {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        } else {
            return nil
        }
    }
    
    var releaseYear: String? {
        guard let releaseDate = releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return nil }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    init(from movieResponse: MovieResponse) {
        self.adult = movieResponse.adult
        self.backdropPath = movieResponse.backdropPath
        self.genres = movieResponse.genreIds.map { Genre(rawValue: $0) ?? .unknown }
        self.id = movieResponse.id
        self.originalLanguage = movieResponse.originalLanguage
        self.originalTitle = movieResponse.originalTitle
        self.overview = movieResponse.overview
        self.popularity = movieResponse.popularity
        self.posterPath = movieResponse.posterPath
        self.releaseDate = movieResponse.releaseDate
        self.title = movieResponse.title
        self.video = movieResponse.video
        self.voteAverage = movieResponse.voteAverage
        self.voteCount = movieResponse.voteCount
    }
}

#if DEBUG
extension Movie {
    static let example = Movie(from: MovieResponse(adult: false, backdropPath: "/bNTHSd3UqqLzIVwbDOGPnx3ScfF.jpg", genreIds: [16, 35, 14], id: 808, originalLanguage: "en", originalTitle: "Shrek", overview: "It ain't easy bein' green -- especially if you're a likable (albeit smelly) ogre named Shrek. On a mission to retrieve a gorgeous princess from the clutches of a fire-breathing dragon, Shrek teams up with an unlikely compatriot -- a wisecracking donkey.", popularity: 222.124, posterPath: "/o04jZs5SXhbvhqO4981W7KJXOWZ.jpg", releaseDate: "2001-05-18", title: "Shrek", video: false, voteAverage: 7.747, voteCount: 17451))
}
#endif
