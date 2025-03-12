//
//  ContentView.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredMovies, id: \.id) { movie in
                    NavigationLink {
                        DetailView(movie: movie)
                    } label: {
                        MovieListEntry(movie: movie)
                    }
                }
            }
            .listRowSpacing(-10)
            .listStyle(.plain)
            .navigationTitle("Popular Movies")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .onChange(of: viewModel.genreFilters) {
                viewModel.filterByGenre()
            }
            .onChange(of: viewModel.searchText) {
                viewModel.filterMovies()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            genreItem(genre: genre)
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

extension MainView {
    func genreItem(genre: Genre) -> some View {
        HStack {
            Button {
                if viewModel.genreFilters.contains(genre) {
                    viewModel.genreFilters.remove(genre)
                } else {
                    viewModel.genreFilters.insert(genre)
                }
            } label: {
                viewModel.genreFilters.contains(genre) ?
                Image(systemName: "checkmark") : nil
                Text(genre.name)
            }
        }
    }
}

#Preview {
    MainView()
}
