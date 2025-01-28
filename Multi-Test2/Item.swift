//
//  Item.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    // Optional properties with default values
    var title: String?
    var timestamp: Date?
    
    init(title: String? = "New Item", timestamp: Date? = .now) {
        self.title = title
        self.timestamp = timestamp
    }
}
