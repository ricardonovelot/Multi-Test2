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
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Item.timestamp, animation: .smooth) private var items: [Item]
    
    @State private var washer = Item.washer
    
    @State private var temperature = "250"
    @State private var cookTime = "00h 00m 00s"
    @State private var selectedMode: String = "Bake"
    @State private var cycleCompleteOption = "Hold Temperature"
    
    @State var isTimerRunning = false

    var body: some View {
        TabView {
            NavigationStack{
                ScrollView{
                    VStack(spacing: 40) {
                        Divider()
                            .overlay(.gray)
                            .padding(.horizontal, 24)
                        
                        
                        NavigationLink{
                            ItemDetailView(
                                item: washer,
                                temperature: $temperature,
                                cookTime: $cookTime,
                                selectedMode: $selectedMode,
                                cycleCompleteOption: $cycleCompleteOption
                                //,isTimerRunning: $isTimerRunning
                            )
                            .navigationBarBackButtonHidden()
                        } label: {
                            HStack(alignment: .center, spacing: 0){
                                Image("hero-KOCE500ESS-3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 260)
                                    .offset(x: -20)
                                    .shadow(color: Color.gray.opacity(0.14), radius: 17, x: 0, y: 9)
                                VStack(alignment: .leading){
                                    Text("Emmily Appliances")
                                        .disclaimer()
                                        .padding(.bottom, 2)
                                    Text(washer.title ?? "")
                                        .font(.system(size: 20, weight: .regular, design: .default))
                                    Divider()
                                        .frame(width: 130, height: 1)
                                        .overlay(.accent)
                                    Text("Online")
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
                        
                        
                        
                        
                        Divider()
                            .overlay(.gray)
                            .padding(.horizontal, 44)
                        
                        HStack(alignment: .center, spacing: 0){
                            
                            Spacer()
                            Spacer()
                            
                            VStack(alignment: .trailing){
                                Text("Emmily Appliances")
                                    .disclaimer()
                                    .padding(.bottom, 2)
                                Text("Wall Oven")
                                    .paragraphMedium()
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
                
                .safeAreaInset(edge: .top) {
                    VStack{
                        HStack{
                            Text("ApplianceHub")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(.accent))
                            Spacer()
                            
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .light, design: .rounded))
                                .foregroundStyle(Color(.accent))
                                .padding(.trailing)
                        }
                        .padding(.bottom, 24)
                        HStack{
                            Text("My Devices")
                                .h2()
                                .font(.system(size: 32, weight: .semibold, design: .default))
                            Spacer()
                        }
                        .padding(.bottom, 8)
                    }
                    .padding(.leading, 22)
                    .background(.white)
                }
            }
                
                .tabItem {
                    Label("APPLIANCES", systemImage: "house")
                        .buttonStyle(.plain)
                }
                
                Text("Title")
                    .tabItem {
                        Label("SETTINGS", systemImage: "gearshape")
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

struct AsyncContentView<Content: View>: View {
    let content: () -> Content
    @State private var isLoading = true

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                content()
            }
        }
        .onAppear {
            // Delay loading by a fraction of a second to avoid UI blocking
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isLoading = false
            }
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
