//
//  Modifiers.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/30.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.gray.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
       content
        .font(.system(style, design: .serif))
   }
}

struct CustomFontModifier: ViewModifier {
    var size: CGFloat = 28
    func body(content: Content) -> some View {
        content.font(.custom("Roboto-Medium", size: size))
    }
}
