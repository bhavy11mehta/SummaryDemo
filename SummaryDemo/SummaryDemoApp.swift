//
//  SummaryDemoApp.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI

@main
struct SummaryDemoApp: App {
    let sessionManager = SessionManager()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if sessionManager.isLoggedIn {
                NavigationStack {
                    HomeView()
                } .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(sessionManager)
            } else {
                NavigationStack {
                    LoginView()
                   
                }     .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(sessionManager)
            }
            
               
        }
    }
}
