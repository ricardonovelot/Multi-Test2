//
//  Multi_Test2App.swift
//  Multi-Test2
//
//  Created by Ricaro Lopez Novelo on 18/12/24.
//

import SwiftUI
import SwiftData
import CloudKit
import UserNotifications

@main
struct Multi_Test2App: App {
    // Initialize container for CloudKit sync
    let container: ModelContainer
    let cloudKitContainer = CKContainer(identifier: "iCloud.com.ricardonovelo.Multi-Test2")
    
    // Add state object to track errors
    @State private var showError = false
    @State private var errorMessage = ""
    
    init() {
        do {
            // Configure SwiftData with CloudKit settings
            // Ensure CloudKit container is properly configured for production
            let config = ModelConfiguration(
                allowsSave: true,
                cloudKitDatabase: .automatic
            )
            
            // Initialize container
            container = try ModelContainer(
                for: Item.self,
                configurations: config
            )
            
            // Clean and reload sample data after container initialization
            let context = container.mainContext
            Item.reloadSampleData(modelContext: context)
            
            // Setup notifications when app launches
            setupNotifications()
            
        } catch {
            // Handle SwiftData errors
            if let swiftDataError = error as? SwiftDataError {
                fatalError("SwiftData error: \(swiftDataError.localizedDescription)")
            } else {
                fatalError("Could not initialize ModelContainer: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: Error, operation: String) {
        let errorMessage: String
        
        if let cloudError = error as? CKError {
            switch cloudError.code {
            case .networkFailure, .networkUnavailable:
                errorMessage = "Network connection is unavailable. Please check your internet connection."
            case .notAuthenticated:
                errorMessage = "Please sign in to iCloud to use sync features."
            case .quotaExceeded:
                errorMessage = "iCloud storage quota exceeded."
            default:
                errorMessage = "CloudKit error: \(cloudError.localizedDescription)"
            }
        } else {
            errorMessage = "\(operation) failed: \(error.localizedDescription)"
        }
        
        DispatchQueue.main.async {
            self.errorMessage = errorMessage
            self.showError = true
        }
    }
    
    // MARK: - Notification Setup
    private func setupNotifications() {
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                self.handleError(error, operation: "Notification permission request")
                return
            }
            
            guard granted else {
                self.handleError(NSError(domain: "", code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Notification permissions were denied"]),
                    operation: "Notification setup")
                return
            }
            
            // Setup CloudKit subscription on main queue
            DispatchQueue.main.async {
                let subscription = CKDatabaseSubscription(subscriptionID: "items-changes")
                let notificationInfo = CKSubscription.NotificationInfo()
                notificationInfo.shouldSendContentAvailable = true
                subscription.notificationInfo = notificationInfo
                
                let operation = CKModifySubscriptionsOperation(
                    subscriptionsToSave: [subscription],
                    subscriptionIDsToDelete: nil
                )
                operation.qualityOfService = .utility
                operation.modifySubscriptionsCompletionBlock = { _, _, error in
                    if let error = error {
                        self.handleError(error, operation: "CloudKit subscription setup")
                    }
                }
                self.cloudKitContainer.privateCloudDatabase.add(operation)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            NavigationStack {
                PrototypesView()
                    .alert("Error", isPresented: $showError) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(errorMessage)
                    }
            }
            #else
            DevicesList()
            #endif
        }
        .modelContainer(container)
    }
}
