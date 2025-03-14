//
//  MovieListEntry.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Kingfisher
import SwiftUI

struct MovieListEntry: View {
    @ObservedObject var viewModel: MovieListEntryViewModel
    
    init(movie: Movie) {
        viewModel = MovieListEntryViewModel(movie: movie)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                KFImage(viewModel.posterUrl)
                    .placeholder({
                        ProgressView()
                    })
                    .resizable()
                    .scaledToFill()
                .frame(width: 25, height: viewModel.cellHeight)
                
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.title)
                    Spacer()
                    Text(viewModel.releaseYear)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .frame(height: viewModel.cellHeight, alignment: .top)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieListEntry(movie: .example)
        .padding()
}
