//
//  MovieCell.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct MovieCell: View {
    @Binding var movie: Movie
    var body: some View {
        HStack {
            ImageSection(isFavourite: $movie.isFavourite)
            Spacer()
            CellDetails(movieName: movie.name,
                        movieYear: movie.year,
                        movieRating: $movie.rating)
        }
        .background(Constants.Colors.MovieCell.background)
        .cornerRadius(Constants.Sizes.MovieCell.corners)
    }
}

fileprivate struct CellDetails: View {
    var movieName, movieYear: String
    @Binding var movieRating: Movie.Rating

    var body: some View {
        VStack(alignment: .trailing) {
            Text(movieName)
                .font(.largeTitle)
                .multilineTextAlignment(.trailing)
                .foregroundColor(Constants.Colors.MovieCell.fontColor)
            Text(movieYear)
                .font(.caption)
                .foregroundColor(Constants.Colors.MovieCell.fontColor)
            HStack {
                StarsView(currentRating: $movieRating)
                    .disabled(true)
            }
        }.padding(.horizontal)
    }
}

fileprivate struct ImageSection: View {
    @Binding var isFavourite: Bool
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("tombraider")
                .resizable()
                .frame(height: Constants.Sizes.MovieCell.imageHeight)
                .aspectRatio(2/3,
                             contentMode: .fit)
                .shadow(radius: Constants.Sizes.MovieCell.imageShadow)
            
            if isFavourite {
                Banner(width: Constants.Sizes.MovieCell.bannerWidth,
                       height: Constants.Sizes.MovieCell.bannerHeight,
                       content: RoundedStar()
                        .foregroundColor(.yellow))
                    .padding(.horizontal)
            }
        }
    }
}


