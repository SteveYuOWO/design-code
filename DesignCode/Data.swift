//
//  Data.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/31.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post])->()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            print("fatal error: get Posts Wrong, see Data.swift")
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            guard let data = data else {
                print("URL Session: data is none")
                return
            }
            let posts = try! JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}
