//
//  RemindersAppApp.swift
//  RemindersApp
//
//  Created by Ravikanth  on 7/5/24.
//

import SwiftUI

@main
struct RemindersAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
