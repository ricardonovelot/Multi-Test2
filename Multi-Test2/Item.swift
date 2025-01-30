//
//  Item.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import Foundation
import SwiftData

@Model
class Item {
    // Optional properties with default values
    var title: String?
    var timestamp: Date?
    var isOn: Bool?
    var imageName: String?
    
    init(title: String = String(), timestamp: Date = Date(), isOn: Bool = false, imageName: String = String()) {
        self.title = title
        self.timestamp = timestamp
        self.isOn = isOn
        self.imageName = imageName
    }
}
