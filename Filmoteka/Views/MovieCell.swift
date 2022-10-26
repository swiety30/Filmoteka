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
            ImageSection(isFavourite: $movie.isFavourite,
                         imageStringURL: movie.logoImageURL)
            Spacer()
            CellDetails(movieName: movie.name,
                        movieYear: movie.year,
                        movieImageURL: movie.logoImageURL,
                        movieRating: $movie.rating)
        }
        .background(Constants.Colors.MovieCell.background)
        .cornerRadius(Constants.Sizes.MovieCell.corners)
    }
}

fileprivate struct CellDetails: View {
    var movieName, movieYear, movieImageURL: String
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
    let imageStringURL: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let url = URL(string: imageStringURL) {
                AsyncImage(url: url)
                    .frame(height: Constants.Sizes.MovieCell.imageHeight)
                    .shadow(radius: Constants.Sizes.MovieCell.imageShadow)
            } else {
                Image("tombraider")
                    .frame(height: Constants.Sizes.MovieCell.imageHeight)
                    .shadow(radius: Constants.Sizes.MovieCell.imageShadow)
            }
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
