//
//  DetailView.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Kingfisher
import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    init(movie: Movie) {
        viewModel = DetailViewModel(movie: movie)
    }
    
    var body: some View {
        VStack {
            KFImage(viewModel.movie.posterURL)
                .placeholder({
                    ProgressView()
                })
                .resizable()
                .scaledToFit()

            Text(viewModel.movie.title ?? "")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(viewModel.movie.overview ?? "")
        }
        .padding()
        .navigationTitle(viewModel.movie.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.isSheetPresented = true
                } label: {
                    Image(systemName: "star")
                }
            }
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            RatingView(movieId: viewModel.movie.id)
        }
    }
}

#Preview {
    DetailView(movie: .example)
}
