//
//  DetailView.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import SwiftUI

struct DetailView: View {
    @State private var showingSheet: Bool = false
    let movie: Movie
    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }

            Text(movie.title ?? "")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(movie.overview ?? "")
        }
        .padding()
        .navigationTitle(movie.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingSheet = true
                } label: {
                    Image(systemName: "star")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            RatingView(movieId: movie.id)
        }
    }
}

#Preview {
    DetailView(movie: .example)
}
