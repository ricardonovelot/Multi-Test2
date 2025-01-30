//
//  TimerView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 29/01/25.
//

import SwiftUI

struct TimerView: View {
    
    // Add AppStorage
    @AppStorage("test1Completed") private var test1Completed = false
    
    // Add parameters for data from ItemDetailView
    let initialTemperature: String
    let initialCookTime: String
    let selectedMode: String
    let cycleCompleteOption: String
    
    // Timer and temperature state
    @State private var temperature: Int
    @State private var remainingTime: TimeInterval
    @State private var isTimerRunning = false
    @State private var showingTimeEditor = false
    
    // Add alert state
    @State private var showCompletionAlert = false
    
    // Time editor state
    @State private var selectedHours = 1
    @State private var selectedMinutes = 30
    @State private var selectedSeconds = 0
    
    // Add initializer
    init(temperature: String, cookTime: String, mode: String, cycleComplete: String) {
        self.initialTemperature = temperature
        self.initialCookTime = cookTime
        self.selectedMode = mode
        self.cycleCompleteOption = cycleComplete
        
        // Initialize state properties
        _temperature = State(initialValue: Int(temperature) ?? 350)
        
        // Convert cookTime string (format: "00h 00m 00s") to seconds
        let components = cookTime.components(separatedBy: " ")
        let hours = Int(components[0].replacingOccurrences(of: "h", with: "")) ?? 0
        let minutes = Int(components[1].replacingOccurrences(of: "m", with: "")) ?? 0
        let seconds = Int(components[2].replacingOccurrences(of: "s", with: "")) ?? 0
        _remainingTime = State(initialValue: TimeInterval(hours * 3600 + minutes * 60 + seconds))
    }
    
    // Timer instance
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                // Oven type and temperature header
                VStack(alignment: .leading, spacing: 8) {
                    Text("OVEN")
                        .disclaimer()
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("\(selectedMode) \(temperature)°")
                            .h2()
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "lightbulb")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)
                
                // Timer circle
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 6)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(remainingTime / (TimeInterval(1 * 3600 + 30 * 60 + 0))))
                        .stroke(Color.black, lineWidth: 6)
                        .rotationEffect(.degrees(-90))
                    
                    VStack(spacing: 8) {
                        Text("\(temperature)°F")
                            .h3()
                            .font(.system(size: 24))
                        
                        Text(timeString(from: remainingTime))
                            .h1()
                        
                        Button {
                            // Set the picker values to current time before showing alert
                            selectedHours = Int(remainingTime) / 3600
                            selectedMinutes = Int(remainingTime) / 60 % 60
                            selectedSeconds = Int(remainingTime) % 60
                            showingTimeEditor = true
                        } label: {
                            Text("Edit Cook Time")
                                .buttonText()
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(width: 300, height: 300)
                .padding()
                
                Spacer()
                // Control buttons
                Button(action: {
                    // Edit cooking logic to be implemented
                }) {
                    Text("Modify Temperature")
                        .buttonText()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                Button(action: {
                    isTimerRunning.toggle()
                }) {
                    Text(isTimerRunning ? "End Cycle" : "TURN ON")
                        .buttonText()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                Spacer()
            }
        }
            .alert("Test 1 Completed", isPresented: $showCompletionAlert) {
                Button("OK") {
                    
                }
            } message: {
                Text("You have successfully completed Test 1!")
            }
            .alert("Edit Cooking Time", isPresented: $showingTimeEditor) {
                NavigationView {
                    Form {
                        HStack {
                            Picker("Hours", selection: $selectedHours) {
                                ForEach(0...23, id: \.self) { hour in
                                    Text("\(hour)h").tag(hour)
                                }
                            }
                            #if os(iOS)
                            .pickerStyle(WheelPickerStyle())
                            #endif
                            Picker("Minutes", selection: $selectedMinutes) {
                                ForEach(0...59, id: \.self) { minute in
                                    Text("\(minute)m").tag(minute)
                                }
                            }
                            #if os(iOS)
                            .pickerStyle(WheelPickerStyle())
                            #endif
                            Picker("Seconds", selection: $selectedSeconds) {
                                ForEach(0...59, id: \.self) { second in
                                    Text("\(second)s").tag(second)
                                }
                            }
                            #if os(iOS)
                            .pickerStyle(WheelPickerStyle())
                            #endif
                        }
                    }
                    #if os(iOS)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingTimeEditor = false
                        },
                        trailing: Button("Done") {
                            // Convert selected time to seconds
                            remainingTime = TimeInterval(
                                selectedHours * 3600 +
                                selectedMinutes * 60 +
                                selectedSeconds
                            )
                            showingTimeEditor = false
                        }
                    )
                    #endif
                }
            }
            .onReceive(timer) { _ in
                if isTimerRunning {
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        isTimerRunning = false
                        test1Completed = true
                        showCompletionAlert = true
                    }
                }
            }
            .onAppear {
                isTimerRunning = true
            }
        
    }
    
    // Helper function to convert seconds to formatted time string
    private func timeString(from timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
        TimerView(temperature: "350", cookTime: "01h 30m 00s", mode: "Bake", cycleComplete: "Hold Temperature")
}
