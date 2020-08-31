//
//  Home.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var menuViewState = CGSize.zero
    @State var showContent = false
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
//
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 220)
                    }
                    .background(Color("background1"))
                )
            
            MenuView()
                .offset(y: showProfile ? 0: screen.height)
                .offset(menuViewState)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.menuViewState = value.translation
                            if self.menuViewState.height < -20 {
                                self.menuViewState.height = -20
                            }
                            if self.menuViewState.height > 20 {
                                self.showProfile = false
                            }
                        })
                        .onEnded({ value in
                            self.menuViewState = .zero
                        })
                )
            
            if showContent {
                Color("background1").edgesIgnoringSafeArea(.all)
                CertificateCardView()
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .onTapGesture {
                    self.showContent = false
                }
                .offset(x: -16, y: -16)
                .transition(.move(edge: .top))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environment(\.colorScheme, .dark)
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }) {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
