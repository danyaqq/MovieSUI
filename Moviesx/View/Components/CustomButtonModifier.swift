//
//  CustomButtonModifier.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    var borderColor: Color
    var backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width - 100, height: 50)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.white)
            .background(backgroundColor)
            .contentShape(RoundedRectangle(cornerRadius: 6))
            .cornerRadius(6)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(lineWidth: 2).foregroundColor(borderColor))
          
    }
}
