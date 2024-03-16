//
//  Item.swift
//  devhub
//
//  Created by Chanakan Mungtin on 16/3/2567 BE.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
