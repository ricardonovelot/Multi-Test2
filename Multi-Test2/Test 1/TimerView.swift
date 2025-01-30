//
//  TimerView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 29/01/25.
//

import SwiftUI

struct TimerView: View {
    // Timer and temperature state
    @State private var temperature: Int = 350
    @State private var remainingTime: TimeInterval = 5400 // 1:30:00 in seconds
    @State private var isTimerRunning = false
    @State private var showingTimeEditor = false
    
    // Time editor state
    @State private var selectedHours = 1
    @State private var selectedMinutes = 30
    @State private var selectedSeconds = 0
    
    // Timer instance
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 20) {
            // Oven type and temperature header
            VStack(alignment: .leading, spacing: 8) {
                Text("OVEN")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("Bake \(temperature)°")
                        .font(.title)
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
                    .trim(from: 0, to: CGFloat(remainingTime / 5400))
                    .stroke(Color.black, lineWidth: 6)
                    .rotationEffect(.degrees(-90))
                
                VStack(spacing: 8) {
                    Text("\(temperature)°F")
                        .font(.system(size: 24))
                    
                    Text(timeString(from: remainingTime))
                        .font(.system(size: 40, weight: .medium))
                    
                    Button("EDIT COOK TIME") {
                        // Set the picker values to current time before showing alert
                        selectedHours = Int(remainingTime) / 3600
                        selectedMinutes = Int(remainingTime) / 60 % 60
                        selectedSeconds = Int(remainingTime) % 60
                        showingTimeEditor = true
                    }
                    .font(.caption)
                }
            }
            .frame(width: 300, height: 300)
            .padding()
            
            // Control buttons
            Button(action: {
                // Edit cooking logic to be implemented
            }) {
                Text("EDIT COOKING")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            Button(action: {
                isTimerRunning.toggle()
            }) {
                Text(isTimerRunning ? "TURN OFF" : "TURN ON")
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
                        .pickerStyle(WheelPickerStyle())
                        
                        Picker("Minutes", selection: $selectedMinutes) {
                            ForEach(0...59, id: \.self) { minute in
                                Text("\(minute)m").tag(minute)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Picker("Seconds", selection: $selectedSeconds) {
                            ForEach(0...59, id: \.self) { second in
                                Text("\(second)s").tag(second)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
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
            }
        }
        .onReceive(timer) { _ in
            if isTimerRunning && remainingTime > 0 {
                remainingTime -= 1
            }
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
    TimerView()
}
