//
//  MovieListEntry.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import SwiftUI

struct MovieListEntry: View {
    let movie: Movie
    let cellHeight: CGFloat = 120
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                AsyncImage(url: movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 25, height: cellHeight)
                
                VStack(alignment: .leading) {
                    Text(movie.title ?? "")
                        .font(.title)
                    Spacer()
                    Text(movie.releaseYear ?? "")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(height: cellHeight, alignment: .top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieListEntry(movie: .example)
}
