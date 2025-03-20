//
//  MovieResponse.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation

struct MovieResponse: Decodable, Identifiable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    public let originalLanguage: String?
    public let originalTitle, overview: String?
    public let popularity: Double
    public let posterPath: String?
    public let releaseDate, title: String?
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    public init(adult: Bool, backdropPath: String?, genreIds: [Int], id: Int, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double, posterPath: String?, releaseDate: String?, title: String?, video: Bool, voteAverage: Double, voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    public var posterURL: URL? {
        if posterPath == nil { return nil }
        if posterPath!.isEmpty { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath!)")!
    }
    
    public var releaseYear: String? {
        guard let releaseDate = releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return nil }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
}
