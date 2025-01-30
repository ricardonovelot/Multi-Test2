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
    static let washer = Item(title: "Washer", timestamp: Date(), isOn: false, imageName: "hero-KOCE500ESS-3")
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(washer)
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
//
//extension ModelContainer {
//    static var sample: () throws -> ModelContainer = {
//        let schema = Schema([Item.self])
//        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: schema, configurations: [configuration])
//        Task { @MainActor in
//            Item.insertSampleData(modelContext: container.mainContext)
//        }
//        return container
//    }
//}
