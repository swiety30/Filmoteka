//
//  CustomTabBar.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 03/11/2021.
//

import SwiftUI

struct FilmotekaTabBar: View {
    @StateObject var viewRouter: ViewRouter
    let size: CGSize

    var body: some View {
        HStack {
            TabBarIcon(viewRouter: viewRouter, assignedView: .notWatched, width: size.width / 3, height: size.height / 4, systemIconName: "homekit", tabName: "to watch")
            plusButton(width: size.width, height: size.height)
                .offset(y: -size.height / 2)
            TabBarIcon(viewRouter: viewRouter, assignedView: .watched, width: size.width / 3, height: size.height / 4, systemIconName: "homekit", tabName: "watched")
        }
        .frame(width: size.width, height: size.height)
        .background(Color.gray.opacity(70).shadow(radius: 2))
    }
}

struct TabBarIcon: View {
    @StateObject var viewRouter: ViewRouter
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
        .foregroundColor(viewRouter.currentView == assignedView ? .black : .white)
    }
}
