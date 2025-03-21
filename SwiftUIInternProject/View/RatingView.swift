//
//  RatingView.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import SwiftUI

public struct RatingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: RatingViewModel
    
    init(movieId: Int) {
        viewModel = RatingViewModel(movieId: movieId)
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Text("Send rating to TMDB:")
                .font(.title)
            HStack(spacing: 5) {
                ForEach(1...10, id: \.self) { index in
                    Image(systemName: index <= viewModel.rating  ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(index <= viewModel.rating ? .yellow : .gray)
                        .onTapGesture {
                            viewModel.rating = index
                        }
                }
            }
            Button("Send rating: \(viewModel.rating)") {
                viewModel.sendRating(rating: viewModel.rating)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Cancel") {
                dismiss()
            }
            .buttonStyle(.plain)
        }
        .onChange(of: viewModel.success) { _, newValue in
            if newValue {
                dismiss()
            }
        }
    }
}

#Preview {
    RatingView(movieId: 808)
}
