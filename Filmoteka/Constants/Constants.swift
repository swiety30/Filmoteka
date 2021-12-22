//
//  Constants.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 22/12/2021.
//

import SwiftUI

struct Constants {
    struct Colors {
        static let filledStarColor = Color.yellow
        static let emptyStarColor = Color.white
        static let starGlowColor = Color.orange
        static let mainBackground = LinearGradient(gradient: Gradient(colors: [Color(red: 84/255, green: 35/255, blue: 68/255),
                                                                               Color(red: 191/255, green: 209/255, blue: 229/255),
                                                                               Color(red: 235/255, green: 245/255, blue: 238/255)]),
                                                   startPoint: .bottomLeading,
                                                   endPoint: .topTrailing)
        static let detailsBackground = Color(red: 191/255, green: 209/255, blue: 229/255)
        static let navigationBackground = UIColor(red: 84/255, green: 35/255, blue: 68/255, alpha: 0.6)
        struct TabBar {
            static let assignedTab = Color.black
            static let notAssignedTab = Color.white
            static let background = Color(red: 84/255, green: 35/255, blue: 68/255)
        }
        struct MovieCell {
            static let fontColor = Color.black
            static let background = Color(red: 235/255, green: 245/255, blue: 238/255)
        }

        struct CategoriesView {
            static let markedCategory = Color.green
        }
        struct Banner {
            static let frameColor = Color(red: 218 / 255, green: 165 / 255, blue: 32/255)
            static let backgroundColor = Color.red
        }

        struct PlusButton {
            static let enabledBackgroundColor = Color.orange
            static let disabledBackgroundColor = Color.gray
            static let strokeColor = Color.white
            static let imageColor = Color.white
            static let shadowColor = Color.orange
        }

        struct MovieDetails {
            static let dividerLineColor = Color.gray
            static let dividerTextColor = Color.black
            static let fontColor = Color.black


            struct WatchedButton {
                static let fontColor = Color.black
                static let backgroundColor = Color(red: 235/255, green: 245/255, blue: 238/255)
            }
        }
    }

    struct Sizes {
        static let glowSize: CGFloat = 4
        static let starStroke: CGFloat = 2
        static let defaultStarSize: CGFloat = 20
        static let favouriteStarSize: CGFloat = 30
        static let detailsStarSize: CGFloat = 50

        struct MovieCell {
            static let corners: CGFloat = 20
            static let bannerHeight: CGFloat = 70
            static let bannerWidth: CGFloat = 30
            static let imageShadow: CGFloat = 10
            static let imageHeight: CGFloat = 200
        }
        
        struct MovieDetails {
            struct ImageSection {
                static let corners: CGFloat = 20
                static let shadow: CGFloat = 10
                static let backgroundOpacity: CGFloat = 0.5
            }
            struct NotesSection {
                static let corners: CGFloat = 20
            }
        }
        struct Banner {
            static let padding: CGFloat = 4
        }

        struct PlusButton {
            static let stroke: CGFloat = 3
            static let opacity: CGFloat = 80
        }
    }
}
