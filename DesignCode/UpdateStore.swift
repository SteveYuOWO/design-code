//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Steve Yu on 2020/8/28.
//  Copyright © 2020 steveyu. All rights reserved.
//

import SwiftUI

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
