//
//  ContentView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [Item]

    var body: some View {
        NavigationStack{
            ScrollView{
                    HStack{
                        Text("My Devices")
                            .font(.system(size: 38, weight: .semibold, design: .default))
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.bottom, 32)
                
                VStack(spacing: 40) {
                    
                    NavigationLink {
                        ItemDetailView(item: Item())
                    } label: {
                        HStack(alignment: .center, spacing: 0){
                            Image("hero-KOCE500ESS-3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 260)
                                .offset(x: -20)
                                .shadow(color: Color.gray.opacity(0.14), radius: 17, x: 0, y: 9)
                            VStack(alignment: .leading){
                                Text("Washer")
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                Divider()
                                    .frame(width: 130, height: 1)
                                    .overlay(.accent)
                                Text("Running")
                                    .padding(.bottom)
                                HStack{
                                    Image(systemName: "batteryblock").rotationEffect(.degrees(180))
                                        .foregroundStyle(.accent)
                                    Image(systemName: "play.square")
                                        .foregroundStyle(.accent)
                                }
                            }
                            .padding()
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    HStack(alignment: .center, spacing: 0){
                        
                        Spacer()
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("Wall Oven")
                                .font(.system(size: 20, weight: .regular, design: .default))
                            Divider()
                                .frame(width: 130, height: 1)
                                .overlay(.accent)
                            Text("Ready to Cook")
                                .padding(.bottom)
                            HStack{
                                Image(systemName: "play.square")
                                    .foregroundStyle(.accent)
                            }
                        }
                        
                        Image("hero-KOCE500ESS-1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .offset(x: 30)
                            .shadow(color: Color.gray.opacity(0.14), radius: 17, x: 0, y: 9)
                        
                        
                    }
                }
               
            }
            .contentMargins(.top, -40)
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
        

//        NavigationStack {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        ItemDetailView(item: item)
//                    } label:{
//                        Text(item.title ?? "")
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .navigationTitle("My Appliances")
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        }
    }
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
            try? modelContext.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
            try? modelContext.save()
        }
    }
}



func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
