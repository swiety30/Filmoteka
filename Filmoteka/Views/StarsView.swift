//
//  StarsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct StarsView: View {
    @Binding var currentRating: Movie.Rating
    var starSize: CGFloat = Constants.Sizes.defaultStarSize
    var onGestureTap: ((Movie.Rating) -> ())?

    var body: some View {
        HStack {
            ForEach(Movie.Rating.allCases, id: \.self) { rating in
                Group {
                    if isFilled(rating) {
                        filledStar
                    } else {
                        emptyStar
                    }
                }
                .onTapGesture {
                    onGestureTap?(rating)
                }
            }
        }
    }
    
    var filledStar: some View {
        RoundedStar()
            .frame(width: starSize, height: starSize)
            .foregroundColor(Constants.Colors.filledStarColor)
    }

    var emptyStar: some View {
        ZStack {
            RoundedStar()
                .stroke(lineWidth: Constants.Sizes.starStroke)
                .foregroundColor(Constants.Colors.filledStarColor)
                .frame(width: starSize, height: starSize)

            RoundedStar()
                .foregroundColor(Constants.Colors.emptyStarColor)
                .frame(width: starSize, height: starSize)
        }
    }

    private func isFilled(_ rating: Movie.Rating) -> Bool {
        currentRating.rawValue >= rating.rawValue
    }
}
