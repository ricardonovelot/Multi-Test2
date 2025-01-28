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
    
    init() {
        do {
            // Configure SwiftData with CloudKit settings
            let config = ModelConfiguration(
                allowsSave: true, cloudKitDatabase: .automatic
            )
            container = try ModelContainer(for: Item.self, configurations: config)
            
            // Setup notifications when app launches
            setupNotifications()
            
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    // MARK: - Notification Setup
    private func setupNotifications() {
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            
            // Setup CloudKit subscription on main queue
            DispatchQueue.main.async {
                let subscription = CKDatabaseSubscription(subscriptionID: "items-changes")
                let notificationInfo = CKSubscription.NotificationInfo()
                notificationInfo.shouldSendContentAvailable = true
                subscription.notificationInfo = notificationInfo
                
                // Save subscription using singleton container
                let operation = CKModifySubscriptionsOperation(
                    subscriptionsToSave: [subscription],
                    subscriptionIDsToDelete: nil
                )
                operation.qualityOfService = .utility
                operation.modifySubscriptionsCompletionBlock = { _, _, error in
                    if let error = error {
                        print("Failed to save subscription: \(error)")
                    }
                }
                CKContainer(identifier: "iCloud.com.ricardonovelo.Multi-Test2")
                    .privateCloudDatabase.add(operation)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
