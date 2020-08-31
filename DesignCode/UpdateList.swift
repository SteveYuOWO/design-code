//
//  UpdateList.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "NewItem", text: "text", date: "Jan1"))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.store.updates) { item in
                    NavigationLink(destination: UpdateDetail(update: item)) {
                        HStack {
                            Image(item.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .background(Color.black)
                                .cornerRadius(20)
                                .padding(.trailing, 4)
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(item.title)
                                    .font(.system(size: 20, weight: .bold))
                                Text(item.text)
                                    .lineLimit(2)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                Text(item.date)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove(perform: {(source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                })
            }
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                Text("Add Updates")
            }, trailing: EditButton())
        }
    .background(Color("background1"))
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
            .environment(\.colorScheme, .dark)
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like data, packages and CMS", date: "Jan 12"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high coverting landing page with advanced interactions, payments and CMD", date: "Feb 21"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web", date: "Mar 3"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in XCode 11", date: "Mar 3"),
    Update(image: "Card5", title: "Framer PlayGround", text: "Create powerful animations and interactions with the Framer X code editor", date: "Mar 3")
]
