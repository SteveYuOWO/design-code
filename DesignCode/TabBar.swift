//
//  TabBar.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            CertificateCardView().tabItem({
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            })
            CourseList().tabItem({
                Image(systemName: "sportscourt")
                Text("Courses")
            })
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environment(\.colorScheme, .dark)
//            .previewDevice("iPhone 11 Pro Max")
    }
}
