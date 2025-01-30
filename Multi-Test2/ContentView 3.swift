//
//  ContentView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import SwiftUI
import SwiftData


struct Device: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
}

struct ContentView3: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    // Add state for current device
    @State private var currentDevice = 0
    
    @Namespace private var namespace
    
    
    // Updated devices array with the new Device struct
    let devices = [
        Device(name: "Washer", imageName: "hero-KOCE500ESS-3"),
        Device(name: "Oven", imageName: "hero-KOCE500ESS-1"),
        Device(name: "Dishwasher", imageName: "hero-KOCE500ESS-3"),
        Device(name: "Refrigerator", imageName: "hero-KOCE500ESS-1"),
        Device(name: "Microwave", imageName: "hero-KOCE500ESS-3")
    ]

    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                // Custom navigation bar that moves with content
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            ForEach(devices.indices, id: \.self) { index in
                                Text(devices[index].name)
                                    .font(.system(size: index == currentDevice ? 40 : 32))
                                    .fontWeight(index == currentDevice ? .semibold : .regular)
                                    .foregroundColor(index == currentDevice ? Color(.accent) : Color(.accent).opacity(0.8))
                                    .opacity(index == currentDevice ? 1 : 0.5)
                                    .padding(.vertical, 16)
                                    .id(index)
                                    .onTapGesture {
                                        withAnimation {
                                            currentDevice = index
                                        }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        .scrollTargetLayout()
                    }
                    .contentMargins(.leading, 26, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .overlay(
                        HStack(spacing: 0) {
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .white]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
#if os(iOS)
                            .frame(width: UIScreen.main.bounds.width * 0.4)
                            #endif
                        },
                        alignment: .trailing
                    )
                    .onChange(of: currentDevice) { _, newValue in
                        withAnimation {
                            proxy.scrollTo(newValue, anchor: .leading)
                        }
                    }
                }
                .background(Color.white)
                
                // Device content
                TabView(selection: $currentDevice) {
                    ForEach(devices.indices, id: \.self) { index in
                        VStack {
                            // Device content
                            VStack(alignment: .leading,spacing: 20) {
                                Image(devices[index].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 300, maxHeight: 350)
                                    .shadow(color: Color.gray.opacity(0.14), radius: 17, x: 0, y: 9)
                                
                                // Status display
                                VStack(alignment: .leading, spacing: 8) {
                                    Divider()
                                        .frame(width: 80)
                                        .overlay(Color(.accent))
                                        .padding(.top)
                                    Text("Online")
                                        .font(.system(size: 24))
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.top, 40)
                            
                            Spacer()
                        }
                        .tag(index)
                    }
                }
                #if os(iOS)
                .tabViewStyle(.page(indexDisplayMode: .never))
                #endif
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack{
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Spacer()
                    }
                }
                ToolbarItem{
                    Image(systemName: "plus")
                        .font(.title)
                        .padding(.trailing)
                }
            }
        }
    }
}


#Preview {
    ContentView3()
        .modelContainer(for: Item.self, inMemory: true)
}
