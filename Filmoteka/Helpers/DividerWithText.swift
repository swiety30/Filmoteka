//
//  DividerWithText.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 16/12/2021.
//

import SwiftUI

struct DividerWithText: View {
    var text: String
    var lineColor: Color
    var textColor: Color


    var body: some View {
        HStack {
            line
            Text(text)
                .foregroundColor(textColor)
            line
        }
    }

    var line: some View {
        VStack { Divider() }.padding().foregroundColor(lineColor)
    }
}
