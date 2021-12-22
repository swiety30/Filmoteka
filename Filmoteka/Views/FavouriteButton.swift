//
//  FavouriteButton.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/12/2021.
//

import SwiftUI

struct FavouriteButton: View {
    @Binding var isFavourite: Bool
    var onGestureTap: () -> ()
    var starSize: CGFloat = Constants.Sizes.favouriteStarSize
    
    var body: some View {
        ZStack {
            circleView
            starView
        }
        .onTapGesture {
            onGestureTap()
        }
    }

    var circleView: some View {
        Circle()
            .stroke(lineWidth: Constants.Sizes.starStroke).foregroundColor(Constants.Colors.filledStarColor)
            .frame(width: starSize, height: starSize)
            .shadow(color: Constants.Colors.starGlowColor, radius: Constants.Sizes.glowSize)
    }

    var starView: some View {
        if isFavourite {
            return RoundedStar()
                .frame(width: starSize, height: starSize)
                .foregroundColor(Constants.Colors.filledStarColor)

        } else {
            return RoundedStar()
                .frame(width: starSize, height: starSize)
                .foregroundColor(Constants.Colors.emptyStarColor)
        }
    }

}
