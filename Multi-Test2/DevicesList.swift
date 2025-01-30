//
//  DevicesList.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 28/01/25.
//

import SwiftUI
import SwiftData

struct DevicesList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        HMI(device: item)
                    } label:{
                        Text(item.title ?? "")
                    }
                }
            }
            .navigationTitle("Devices HQ")
        }
    }
}

#Preview {
    DevicesList()
}
