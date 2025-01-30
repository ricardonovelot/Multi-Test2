//
//  HMI.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 28/01/25.
//

import SwiftUI
import SwiftData

struct HMI: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var device: Item
    
    var body: some View {
        
        VStack{
            Text(device.title ?? "" )
            HStack(spacing: 0){
                Text("Appliance Brand")
                    .foregroundStyle(.white)
                VStack(spacing: 0){
                    
                    HStack(spacing: 0){
                        Spacer()
                        Text("WHAT to wash")
                        Spacer()
                        Text("HOW to wash")
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    VStack(spacing: 0){
                        HStack(spacing: 0){
                            VStack{
                                Image(systemName: "power")
                                    .padding()
                                Circle()
                                    .frame(width: 4)
                                    .foregroundColor(device.isOn == true ? .green : .gray)
                            }
                            .onTapGesture {
                                device.isOn?.toggle()
                                try? modelContext.save()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    try? modelContext.save()
                                }
                            }
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Regular")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Whites")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Delicates")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Colors")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Bulky Items")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Towels")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            
                            VStack{
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .padding()
                            }
                            .background(.black)
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Normal")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("SANITIZE with OXI")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Wrinkle control")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Cold Wash")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            VStack(spacing: 0){
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Heavy Duty")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                                
                                HStack{
                                    Circle()
                                        .frame(width: 4)
                                    Text("Quick")
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.green)
                                .multilineTextAlignment(.center)
                            }
                            .frame(width:100)
                            
                            VStack{
                                Image(systemName: "playpause")
                                Text("Hold to Start")
                            }
                            .frame(width: 100)
                        }
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.8))
                        
                        HStack(spacing:0){
                            HStack{
                                Image(systemName: "wifi")
                                Text("Remote Enable")
                            }
                            .layoutPriority(1)
                            Text("LOAD & GO")
                                .frame(maxWidth: .infinity)
                            Text("Fabric Softener")
                                .frame(maxWidth: .infinity)
                            Text("Deep Water")
                                .frame(maxWidth: .infinity)
                            Text("Spin")
                                .frame(maxWidth: .infinity)
                            Text("Temp")
                                .frame(maxWidth: .infinity)
                            Text("Soil")
                                .frame(maxWidth: .infinity)
                            Text("Delay Start")
                                .frame(maxWidth: .infinity)
                            Text("PreSoak")
                                .frame(maxWidth: .infinity)
                            Text("Extra Rinse")
                                .frame(maxWidth: .infinity)
                            Text("More Options")
                                .frame(maxWidth: .infinity)
                        }
                        .font(.system(size: 10))
                        .frame(height: 30)
                        .background(.white.opacity(0.3))
                        .frame(maxWidth: .infinity)
                    }
                    .cornerRadius(16)
                    
                }
                
            }
            .frame(height: 160)
            .frame(width: 1000)
        }
        .background(.gray)
        
        //        VStack{
        //            Text(device.title ?? "" )
        //            HStack{
        //                VStack{
        //                    HStack{
        //                        Image(systemName: device.isOn == true ? "circle.fill" : "circle")
        //                        Text("POWER")
        //                    }
        //                    .padding()
        //                    .cornerRadius(20)
        //                    .contentShape(Rectangle())
        //                    .onTapGesture {
        //                        device.isOn?.toggle()
        //                        try? modelContext.save()
        //
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //                            try? modelContext.save()
        //                        }
        //                    }
        //                    .overlay(
        //                        RoundedRectangle(cornerRadius: 6)
        //                            .stroke(.white, lineWidth: 2)
        //                    )
        //
        //                    Text("Hold 3 Sec")
        //                    Text("Cancel & Drain")
        //                }
        //            }
        //            .preferredColorScheme(.dark)
        //            .frame(height: 180)
        //            Image("hero-KOCE500ESSDW")
        //                .resizable()
        //                .scaledToFit()
        //                .frame(height: 200)
        //        }
        //    }
    }
        
}

#Preview {
    HMI(device: Item())
}
