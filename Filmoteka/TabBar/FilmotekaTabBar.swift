//
//  CustomTabBar.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 03/11/2021.
//

import SwiftUI

struct FilmotekaTabBar: View {
    @ObservedObject var viewRouter: ViewRouter
    let size: CGSize

    var body: some View {
        HStack {
            TabBarIcon(viewRouter: viewRouter,
                       assignedView: .notWatched,
                       width: size.width / 3,
                       height: size.height / 4,
                       systemIconName: "homekit",
                       tabName: "to watch")
            PlusButton(width: size.width / 7,
                       height: size.height / 7,
                       content: NewMovieView())
                .offset(y: -size.height / 2)
            TabBarIcon(viewRouter: viewRouter,
                       assignedView: .watched,
                       width: size.width / 3,
                       height: size.height / 4,
                       systemIconName: "homekit",
                       tabName: "watched")
        }
        .frame(width: size.width, height: size.height)
        .background(Constants.Colors.TabBar.background)
    }
}

struct TabBarIcon: View {
    @ObservedObject var viewRouter: ViewRouter
    let assignedView: ViewToDisplay
    let width, height: CGFloat
    let systemIconName, tabName: String

    var body: some View {
        VStack {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .onTapGesture {
            viewRouter.currentView = assignedView
        }
        .foregroundColor(viewRouter.currentView == assignedView ? Constants.Colors.TabBar.assignedTab : Constants.Colors.TabBar.notAssignedTab)
    }
}
