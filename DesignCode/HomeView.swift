//
//  HomeView.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool
    @State var showUpdate = false
    @Binding var showContent:Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Watching")
                        .font(.largeTitle)
                        .fontWeight(.bold)
    //                    .modifier(CustomFontModifier(size: 10))
                    Spacer()
                    AvatarView(showProfile: $showProfile)
                    
                    Button(action: {self.showUpdate.toggle()}) {
                        Image(systemName: "square.and.arrow.up")
//                            .renderingMode(.original)
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color("background3"))
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                .padding(.horizontal)
                .padding(20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent.toggle()
                        }
                }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sectionData) { item in
                            GeometryReader { geometry in
                                SectionView(section: item).rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in: .global).minX - 60) / -20
                                    ), axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    .padding(30)
                    .padding(.bottom, 30)
                    .offset(y: -30)
                }
                
                
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)

                
                SectionView(section: sectionData[3], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                Spacer()
            }
            .padding(.top, 44)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(y: showProfile ? -400: 0)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
            .rotation3DEffect(Angle(degrees: showProfile ? -5: 0), axis: (x: 10.0, y: 0, z: 0))
            .scaleEffect(showProfile ? 0.9: 1)
            .edgesIgnoringSafeArea(.all)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                Spacer()
                Image(section.logo)
            }
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
        .padding(20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}

let sectionData = [
    Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo3", image: Image("Card3"), color: Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))),
    Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo2", image: Image("Card2"), color: Color("card2")),
    Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
    Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo2", image: Image("Card1"), color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))]

struct WatchRingsView: View {
    var body: some View {
        HStack {
            HStack {
                RingView(color1: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), color2: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), width: 44, height: 44, percent: 60, show: .constant(true))
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("6 minutes left")
                        .modifier(FontModifier(style: .subheadline))
                    
                    Text("Welcome to watching")
                        .modifier(FontModifier(style: .caption))
                }
                .modifier(FontModifier())
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(30)
            .modifier(ShadowModifier())
            
            HStack {
                RingView(color1: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), width: 32, height: 32, percent: 32, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .modifier(ShadowModifier())
            .cornerRadius(30)
            .modifier(ShadowModifier())
            
            HStack {
                RingView(color1: Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)), color2: Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)), width: 32, height: 32, percent: 80, show: .constant(true))
                
            }
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(30)
            .modifier(ShadowModifier())
        }
    }
}
