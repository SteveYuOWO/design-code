//
//  DataStore.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/31.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts(completion: { posts in
            self.posts = posts
        })
    }
}
