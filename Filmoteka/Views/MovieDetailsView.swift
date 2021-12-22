//
//  MovieDetailsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var movieHandler: MoviesHandler
    @Binding var movie: Movie

    @State private var isPresentingCategoriesPopover = false
    @State private var isWatched: Bool = false
    @State private var currentRating: Movie.Rating = .one
    @State private var currentCategoryName: String = ""
    @State private var currentNotes: String = ""
    @State private var isFavourite: Bool = false

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    ImageSection(width: geometry.size.width,
                                 movieName: movie.name,
                                 movieYear: movie.year,
                                 isFavourite: $isFavourite)

                    CategorySection(isPresentingCategoriesPopover: $isPresentingCategoriesPopover,
                                    currentCategoryName: currentCategoryName)

                    MyRatingSection(currentRating: $currentRating)

                    MyNotesSection(currentNotes: $currentNotes,
                                   width: geometry.size.width)

                    DescriptionSection(movieDescription: movie.description)

                    WatchedButton(isWatched: $isWatched)

                    BottomSpacing(height: geometry.size.height / 8)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Constants.Colors.detailsBackground)
        .popover(isPresented: $isPresentingCategoriesPopover) {
            CategoriesView(movieCategory: $currentCategoryName)
        }
        .onAppear {
            currentCategoryName = movie.category
            isWatched = movie.isWatched
            isFavourite = movie.isFavourite
            currentRating = movie.rating
            currentNotes = movie.notes
        }
        .onDisappear {
            movieHandler.updateMovie(movieId: movie.id,
                                     isWatched: isWatched,
                                     isFavourite: isFavourite,
                                     category: currentCategoryName,
                                     rating: currentRating,
                                     notes: currentNotes)

        }
    }
}

fileprivate struct ImageSection: View {
    var width: CGFloat
    var movieName, movieYear: String
    @Binding var isFavourite: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottomTrailing) {
                Image("tombraider2")
                    .resizable()
                    .frame(width: width, height: width / 2)
                    .scaledToFit()

                ZStack(alignment: .bottomTrailing) {
                    Color.black
                        .opacity(Constants.Sizes.MovieDetails.ImageSection.backgroundOpacity)
                    VStack(alignment: .trailing) {
                        Text(movieName)
                            .font(.bold(.largeTitle)())
                        Text(movieYear)
                            .font(.bold(.caption)())
                    }
                    .foregroundColor(.white)
                    .padding()
                }
                .frame(width: width, height: width / 2 / 3)
            }
            .cornerRadius(Constants.Sizes.MovieDetails.ImageSection.corners,
                          corners: [.bottomLeft, .bottomRight])
            .shadow(radius: Constants.Sizes.MovieDetails.ImageSection.shadow)
            
            FavouriteButton(isFavourite: $isFavourite)  {
                isFavourite = !isFavourite
            }
            .padding()
        }
    }
}

fileprivate struct CategorySection: View {
    @Binding var isPresentingCategoriesPopover: Bool
    var currentCategoryName: String

    var body: some View {
        HStack {
            Text("Category: ")
            Spacer()
            HStack {
                Text(currentCategoryName)
                Image(systemName: "arrow.right.to.line.circle")
            }
            .onTapGesture {
                isPresentingCategoriesPopover = true
            }
        }
        .font(.title2)
        .foregroundColor(Constants.Colors.MovieDetails.fontColor)
        .padding()
    }
}

fileprivate struct MyRatingSection: View {
    @Binding var currentRating: Movie.Rating

    var body: some View {
        DividerWithText(text: "My Rating",
                        lineColor: Constants.Colors.MovieDetails.dividerLineColor,
                        textColor: Constants.Colors.MovieDetails.dividerTextColor)

        StarsView(currentRating: $currentRating, starSize: Constants.Sizes.detailsStarSize) { rating in
            currentRating = rating
        }
        .padding()
    }
}

fileprivate struct MyNotesSection: View {
    @Binding var currentNotes: String
    var width: CGFloat

    var body: some View {
        DividerWithText(text: "My Notes",
                        lineColor: Constants.Colors.MovieDetails.dividerLineColor,
                        textColor: Constants.Colors.MovieDetails.dividerTextColor)

        ExpandableTextEditorWithPlaceholder(placeholderText: "Please add notes...",
                                            width: width - 50,
                                            bindingText: $currentNotes)
            .cornerRadius(Constants.Sizes.MovieDetails.NotesSection.corners)
            .padding()
    }
}

fileprivate struct DescriptionSection: View {
    var movieDescription: String

    var body: some View {
        Divider()
            .foregroundColor(Constants.Colors.MovieDetails.dividerLineColor)
            .padding()

        Text(movieDescription)
            .padding(.horizontal)
    }
}

fileprivate struct WatchedButton: View {
    @Binding var isWatched: Bool

    var body: some View {
        Button {
            isWatched = !isWatched
        } label: {
            if isWatched {
                Text("Mark as not watched")
            } else {
                Text("Mark as watched")
            }
        }
        .buttonStyle(GrowingButton(backgroundColor: Constants.Colors.MovieDetails.WatchedButton.backgroundColor,
                                   foregroundColor: Constants.Colors.MovieDetails.WatchedButton.fontColor))
        .padding()
    }
}

fileprivate  struct BottomSpacing: View {
    var height: CGFloat
    var body: some View {
        Rectangle()
            .frame(width: 100, height: height)
            .foregroundColor(.clear)
    }
}

