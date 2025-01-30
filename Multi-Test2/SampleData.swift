//
//  File.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 28/01/25.
//

import Foundation
import SwiftData
import SwiftUI

extension Item {
    static func insertSampleData(modelContext: ModelContext) {
        // Add contacts to the model context.
        let washer = Item(title: "Washer", timestamp: Date(), isOn: false, imageName: "hero-KOCE500ESS-3")
        //modelContext.insert(washer)

        //ross.photo = data ?? Data()
        
        // Animal.dog.category = mammal
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Item.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
