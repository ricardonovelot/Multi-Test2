//
//  PrototypesView.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 29/01/25.
//

import SwiftUI

struct PrototypesView: View {
    
    @State private var showWelcomeAlert = true
    
    @AppStorage("test1Completed") private var test1Completed = true
    @AppStorage("test2Completed") private var test2Completed = true
    @AppStorage("test3Completed") private var test3Completed = true
    
    @State private var showRestartAlert = false
    
    var body: some View {
            List {
                NavigationLink("Test 1") {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }
                NavigationLink("Test 2") {
                    ContentView2()
                        .navigationBarBackButtonHidden(true)
                }
                
                NavigationLink("Test 3") {
                    ContentView3()
                        .navigationBarBackButtonHidden(true)
                }
                
            }
            .contentMargins(.top, 20)
            .navigationTitle("User Test")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button(role: .destructive) {
                            showRestartAlert = true
                        } label: {
                            Label("Restart Test", systemImage: "arrow.clockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .alert("Restart Test?", isPresented: $showRestartAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Restart", role: .destructive) {
                    // Reset all completion states
                    test1Completed = false
                    test2Completed = false
                    test3Completed = false
                }
            } message: {
                Text("This will reset all test progress. Are you sure you want to continue?")
            }
            .alert("Task: Start a Cycle", isPresented: $showWelcomeAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Select 'Test 1' to begin.")
            }
            
        
    }
}

#Preview {
        PrototypesView()
}

#if os(iOS)
// navigationBarBackButtonHidden - swipe back gesture
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
#endif
