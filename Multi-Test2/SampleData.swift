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
    static let washer = Item(title: "Washer", timestamp: Date(), isOn: false)
    //static let img = UIImage(named: "test-1")
    //static let data = img?.jpegData(compressionQuality: 1)
    
    static func insertSampleData(modelContext: ModelContext) {
        // Add contacts to the model context.
        modelContext.insert(washer)

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
