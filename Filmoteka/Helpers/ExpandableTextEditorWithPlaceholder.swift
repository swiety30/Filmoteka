//
//  ExpandableTextEditorWithPlaceholder.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 09/12/2021.
//

import SwiftUI

struct ExpandableTextEditorWithPlaceholder: View {
    var placeholderText: String
    var fontSize: Int = 20
    var lineSpacing: Int = 5
    var width: CGFloat
    @Binding var bindingText: String
    @State private var shouldShowPlaceholder: Bool = true
    @State private var textHeight: CGFloat = 50
    @State private var fontColor: Color?

    var body: some View {
        ZStack {
            TextEditor(text: $bindingText)
                .font(.system(size: CGFloat(fontSize)))
                .lineSpacing(CGFloat(lineSpacing))
                .frame(width: width, height: textHeight)
                .foregroundColor(fontColor)
                .onChange(of: bindingText) { newValue in
                    let numberOfLines = newValue.numberOfLines
                    textHeight = CGFloat(fontSize * numberOfLines + (numberOfLines + 1) * 2 * lineSpacing)
                    if !isTextPlaceholder(newValue) { fontColor = .black }

                }
                .onTapGesture {
                    if isTextPlaceholder(bindingText) {
                        bindingText = ""
                    }
                }
        }
        .onAppear {
            textHeight = CGFloat(fontSize * bindingText.numberOfLines + (bindingText.numberOfLines + 1) * 2 * lineSpacing)
            fontColor = .black
            if bindingText.isEmpty || isTextPlaceholder(bindingText) {
                bindingText = placeholderText
                fontColor = .gray
            }
        }
        .onDisappear {
            if isTextPlaceholder(bindingText) { bindingText = "" }
        }
    }

    private func isTextPlaceholder(_ text: String) -> Bool {
        text == placeholderText
    }
}
