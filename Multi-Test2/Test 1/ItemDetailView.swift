//
//  ItemDetailView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 28/01/25.
//

import SwiftUI

struct ItemDetailView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var item: Item
    
    var modes = ["Bake","Broil","Proof","convect bake","convect bake rapid preheat", "Convect roast", "Convect broil", "Probe Cook", "Grill", "Stone Bake", "Stream", "Steam Assist", "Keep Warm"]
    
    var whenCycleComplete = ["Hold Temperature","Keep Warm","Turn Off"]
    
    @State private var showingTimePicker = false
    @State private var showingCycleCompleteOptions = false
    
    
    @State private var modalSlideOffset: CGFloat = 600
    let offsetAmount: CGFloat = 600
    
    @Binding var temperature: String
    @Binding  var cookTime: String
    @Binding  var selectedMode: String
    @Binding  var cycleCompleteOption: String
    @State private var isTimerRunning = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(){
                    VStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 16){
                            Text("Oven Temperature")
                                .disclaimer()
                            TextField("Temperature", text: $temperature)
                                .keyboardType(.numberPad)
                            Divider()
                            Text("Value must be between 170 and 550")
                                .paragraphExtraSmall()
                                .foregroundStyle(.secondary)
                        }
                        
                        
                        VStack(alignment: .leading, spacing: 20){
                            Text("Cook time")
                                .disclaimer()
                            HStack{
                                Text(cookTime)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.accent)
                            }
                            .contentShape(Rectangle())
                            .padding(.bottom,4)
                            .onTapGesture {
                                showingTimePicker = true
                            }
                            Divider()
                        }
                        
                        VStack(alignment: .leading, spacing: 20){
                            Text("when cycle complete")
                                .disclaimer()
                            HStack{
                                Text(cycleCompleteOption)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.accent)
                            }
                            .contentShape(Rectangle())
                            .padding(.bottom,4)
                            .onTapGesture {
                                showingCycleCompleteOptions = true
                            }
                            Divider()
                        }
                        
                        VStack{
                            Image(systemName: "star")
                                .foregroundStyle(.accent)
                                .font(.title)
                                .padding(.bottom, 4)
                            Text("Save as favorite")
                                .disclaimer()
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        
                        HStack{
                            Text("Remote Enable is ON")
                                .paragraphSmall()
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        
                        NavigationLink{
                            TimerView(
                                temperature: temperature,
                                cookTime: cookTime,
                                mode: selectedMode,
                                cycleComplete: cycleCompleteOption
                            )
                        } label: {
                            HStack{
                                Text("Start")
                                    .buttonText()
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical)
                            }
                            .background(.black)
                            .frame(height: 30)
                            .padding()
                            .padding(.bottom)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                }
                .scrollIndicators(.hidden)
                .safeAreaInset(edge: .top) {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "arrow.left")
                                .fontWeight(.light)
                                .font(.system(size: 28))
                                .onTapGesture {
                                    dismiss()
                                }
                            Spacer()
                            Image(systemName: "star")
                                .foregroundStyle(Color(.accent))
                                .padding(.trailing, 12)
                                .font(.system(size: 28))
                            Image(systemName: "gearshape.2.fill")
                                .foregroundStyle(.gray)
                                .font(.system(size: 28))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                        
                        VStack(alignment: .leading){
                            Text("My appliances")
                                .disclaimer()
                            Text("Oven")
                                .h2()
                        }
                        .padding(.leading)
                        
                        ScrollView(.horizontal) {
                            ScrollViewReader { proxy in
                                HStack(spacing: 12){
                                    ForEach(modes, id: \.self){ mode in
                                        Text(mode)
                                            .buttonText()
                                            .foregroundStyle(selectedMode == mode ? .black : .gray)
                                            .frame(width: 140, height: 60)
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
                        .padding(.bottom)
                        .padding(.bottom)
                        
                    }
                    #if os(iOS)
                    .background(Color(UIColor.systemBackground))
                    #endif
                }
                
                if showingTimePicker {
                    Color.black
                        .ignoresSafeArea()
                        .opacity(modalSlideOffset == 0 ? 0.3 : 0)
                        .animation(.easeInOut(duration: 0.3), value: modalSlideOffset)
                        .onTapGesture {
                            withAnimation(.smooth(duration: 0.3)) {
                                modalSlideOffset = offsetAmount
                            } completion: {
                                showingTimePicker = false
                            }
                        }
                    
                    CookTimePickerView(isPresented: $showingTimePicker,
                      cookTime: $cookTime,
                      slideOffset: $modalSlideOffset)
                        .padding(.horizontal)
                }
                
                if showingCycleCompleteOptions {
                    Color.black
                        .ignoresSafeArea()
                        .opacity(modalSlideOffset == 0 ? 0.3 : 0)
                        .animation(.easeInOut(duration: 0.3), value: modalSlideOffset)
                        .onTapGesture {
                            withAnimation(.smooth(duration: 0.3)) {
                                modalSlideOffset = offsetAmount
                            } completion: {
                                showingCycleCompleteOptions = false
                            }
                        }
                    
                    WhenCycleCompleteView(isPresented: $showingCycleCompleteOptions,
                         cycleCompleteOption: $cycleCompleteOption,
                         slideOffset: $modalSlideOffset)
                        .padding(.horizontal)
                }
            }
        }
        
    }
        
}

#Preview {
    @Previewable var previewTemp = "350"
    @Previewable var previewCookTime = "00h 30m 00s"
    @Previewable var previewMode = "Bake"
    @Previewable var previewCycleComplete = "Hold Temperature"
    
    let previewItem = Item(timestamp: Date())
    
    return ItemDetailView(
        item: previewItem,
        temperature: .constant("350"),
        cookTime: .constant("00h 30m 00s"),
        selectedMode: .constant("Bake"),
        cycleCompleteOption: .constant("Hold Temperature")
    )
    .modelContainer(for: Item.self, inMemory: true)
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

struct CookTimePickerView: View {
    @Binding var isPresented: Bool
    @Binding var cookTime: String
    @Binding var slideOffset: CGFloat
    
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Modal Header
            Text("COOK TIME")
                .disclaimer()
                .padding(.top)
                .padding(.top)
            
            // Time Picker Section
            HStack(spacing: 16) {
                // Hours
                HStack(spacing: 0) {
                    Picker("Hours", selection: $hours) {
                        ForEach(0...12, id: \.self) { value in
                            Text("\(value)")
                        }
                    }
                    #if os(iOS)
                    .pickerStyle(.wheel)
                    #endif
                    .frame(width: 60)
                    
                    Text("Hr")
                        .paragraphSmall()
                }
                
                // Minutes
                HStack(spacing: 0) {
                    Picker("Minutes", selection: $minutes) {
                        ForEach(0...59, id: \.self) { value in
                            Text("\(value)")
                        }
                    }
#if os(iOS)
                    .pickerStyle(.wheel)
#endif
                    .frame(width: 60)
                    
                    Text("Min")
                        .paragraphSmall()
                }
                
                // Seconds
                HStack(spacing: 0) {
                    Picker("Seconds", selection: $seconds) {
                        ForEach(0...59, id: \.self) { value in
                            Text("\(value)")
                        }
                    }
#if os(iOS)
                    .pickerStyle(.wheel)
                    .frame(width: 60)
#endif
                    Text("Sec")
                        .paragraphSmall()
                }
            }
            .padding(.vertical)
            
            // Buttons
            VStack(spacing: 8) {
                Button {
                    let timeString = String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
                    cookTime = timeString
                    isPresented = false
                } label: {
                    Text("OKAY")
                        .buttonText()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                
                Button {
                    isPresented = false
                } label: {
                    Text("CANCEL")
                        .disclaimer()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.horizontal)
        #if os(iOS)
        .background(Color(.systemBackground))
        #endif
        .cornerRadius(12)
        .shadow(radius: 20)
        .offset(y: slideOffset)
        .onAppear {
            withAnimation(.smooth(duration: 0.4)) {
                slideOffset = 0
            }
        }
    }
}

struct WhenCycleCompleteView: View {
    @Binding var isPresented: Bool
    @Binding var cycleCompleteOption: String
    @Binding var slideOffset: CGFloat
    let options = ["Hold Temperature", "Keep Warm", "Turn Off"]
    
    // Add state for animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Modal Header
            Text("WHEN CYCLE COMPLETE")
                .disclaimer()
                .padding(.top)
                .padding(.top)
            
            // Options Section
            VStack(alignment: .leading, spacing: 16) {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        cycleCompleteOption = option
                    }) {
                        VStack(alignment: .leading, spacing: 0){
                            Divider()
                            HStack {
                                Image(systemName: cycleCompleteOption == option ? "largecircle.fill.circle" : "circle")
                                    .font(.system(size: 28))
                                    .foregroundStyle(cycleCompleteOption == option ? .accent : .gray)
                                    
                                Text(option)
                                    .foregroundStyle(cycleCompleteOption == option ? .black : .gray)
                                    .paragraphMedium()
                                    
                            }
                            .padding(.top)
                        }
                    }
                }
            }
            .padding(.vertical, 24)
        }
        .padding(.horizontal)
        #if os(iOS)
        .background(Color(.systemBackground))
        #endif
        .cornerRadius(12)
        .shadow(radius: 20)
        // Add offset and opacity modifiers
        .offset(y: slideOffset)
        // Add onAppear animation
        .onAppear {
            withAnimation(.smooth(duration: 0.4)) {
                slideOffset = 0
            }
        }
    }
}
