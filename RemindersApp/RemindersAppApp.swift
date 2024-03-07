//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Ravikanth  on 7/5/24.
//

import SwiftUI
import UserNotifications

@main
struct RemindersAppApp: App {
    
    init(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { grated, error in
            if grated {
                //
            }else {
                print("\(error)")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
