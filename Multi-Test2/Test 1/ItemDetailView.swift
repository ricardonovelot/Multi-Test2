//
//  ItemDetailView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 28/01/25.
//

import SwiftUI



struct ItemDetailView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var item: Item
    
    var modes = ["daily","tough","custom","normal","express"]

    @State private var temperature = "250"
    @State private var cookTime = "00h 00m 00s"
    
    @State private var selectedMode: String = "daily"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            VStack(alignment: .leading, spacing: 0){
                Text("My appliances")
                    .padding(.bottom,12)
                    .foregroundStyle(.secondary)
                Text("Oven")
                    .font(.system(size: 32, weight: .medium))
            }
            .padding(.leading)
           
            ScrollView(.horizontal) {
                ScrollViewReader { proxy in
                    HStack(spacing: 32){
                        ForEach(modes, id: \.self){ mode in
                            Text(mode)
                                .textCase(.uppercase)
                                .font(.body)
                                .frame(width: 240, height: 60)
                                .border(selectedMode == mode ? .black : .gray)
                                .id(mode)
                                .onTapGesture {
                                    selectedMode = mode
                                    withAnimation {
                                        proxy.scrollTo(mode, anchor: .center)
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.leading, 20)
            .scrollIndicators(.hidden)
            .padding(.vertical)
            
            VStack(alignment: .leading){
                Text("Oven Temperature")
                    .textCase(.uppercase)
                TextField("Temperature", text: $temperature)
                Divider()
                Text("Value must be between 170 and 550")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            
            VStack(alignment: .leading){
                Text("Cook time")
                    .textCase(.uppercase)
                HStack{
                    TextField("00h 00m 00s", text: $cookTime)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.accent)
                }
                .padding(.bottom,4)
                Divider()
            }
            .padding(.horizontal)
            
            HStack{
                Spacer()
                HStack{
                    Image(systemName: "medical.thermometer")
                    Text("Power Preheat ON")
                    Image(systemName: "chevron.down")
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1) // same as lineWidth
                        .stroke(.gray, lineWidth: 1)
                        .shadow(radius: 4)
                )
                Spacer()
            }
            .padding(.vertical)
            
            VStack{
                Image(systemName: "star")
                    .foregroundStyle(.accent)
                    .font(.title)
                    .padding(.bottom, 4)
                Text("Save as favorite")
                    .textCase(.uppercase)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            
            HStack{
                Text("Remote Enable is")
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            HStack{
                Text("Start Now")
                    .textCase(.uppercase)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
            }
            .background(.black)
            .frame(height: 30)
            .padding()
            .padding(.bottom)
            .onTapGesture {
                <#code#>
            }
        }
        .toolbar {
            HStack{
                Image(systemName: "star")
                    .padding(.trailing, 12)
                Image(systemName: "gearshape")
            }
        }
    }
}

#Preview {
    NavigationStack{
        ItemDetailView(item: Item())
    }
}


/*
 for dishwasher
 
 
 enum type {
     case wash
     case dry
 }
 
 @State private var currentType: type = .wash
 @State private var highTemp = false
 @State private var samiRinse = false
 
 HStack{
     VStack{
         Text("Time")
             .font(.headline)
             .textCase(.uppercase)
         Text("2h 10m")
     }
     .frame(maxWidth: .infinity)
     
     VStack{
         HStack{
             Text("Usage")
                 .font(.headline)
                 .textCase(.uppercase)
             Image(systemName: "info.circle")
         }
         HStack(spacing:3){
             Image(systemName: "drop.fill")
             Image(systemName: "drop.fill")
             Image(systemName: "drop.fill")
             Image(systemName: "drop")
             Image(systemName: "drop")
         }
         HStack(spacing:2){
             Image(systemName: "bolt.fill")
             Image(systemName: "bolt.fill")
             Image(systemName: "bolt")
             Image(systemName: "bolt")
             Image(systemName: "bolt")
         }
         
     }
     .frame(maxWidth: .infinity)
 }
 
 HStack{
     VStack{
         Text("Wash")
             .padding(.vertical)
         Divider()
             .overlay(currentType == .wash ? .black : .gray)
     }
     .onTapGesture {
         currentType = .wash
     }
     
     VStack{
         Text("Dry")
             .padding(.vertical)
         Divider()
             .overlay(currentType == .dry ? .black : .gray)
     }
     .onTapGesture {
         currentType = .dry
     }
 }
 
 if currentType == .wash {
     VStack{
         Toggle("HIGH-TEMP", isOn: $highTemp)
             .padding()
         Toggle("SANI-RINSE", isOn: $samiRinse)
             .padding()
     }
 }
 
 
 Spacer()
 
 
 
 */
