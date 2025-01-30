//
//  ContentView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import SwiftUI
import SwiftData

struct ContentView2: View {
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
                
                VStack(spacing: 50) {
                    
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
                                Text("O N L I N E")
                                    .textCase(.uppercase)
                                    .padding(.bottom)
                                    .foregroundStyle(.gray)
                            }
                            .padding()
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    
                    HStack(alignment: .center, spacing: 0){
                        
                        Image("hero-KOCE500ESS-1")
                            .resizable()
                            .scaledToFit()
                            .frame(width:200)
                            .offset(x: -50)
                            .shadow(color: Color.gray.opacity(0.14), radius: 17, x: 0, y: 9)
                        
                        VStack(alignment: .leading){
                            Text("Wall Oven")
                                .font(.system(size: 20, weight: .regular, design: .default))
                            Divider()
                                .frame(width: 130, height: 1)
                                .overlay(.accent)
                            Text("R e a d y  t o  C o o k")
                                .textCase(.uppercase)
                                .padding(.bottom)
                                .foregroundStyle(.gray)
                        }
                        .offset(x: -23)
                        
                        Spacer()
                        
                    }
                }
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
    ContentView2()
        .modelContainer(for: Item.self, inMemory: true)
}
