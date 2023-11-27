//
//  SessionManager.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import Combine
import Foundation

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    // Other user-related properties...

    func login() {
        // Perform login logic and set isLoggedIn to true on successful login
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        isLoggedIn = true
    }

    func logout() {
        // Perform logout logic and set isLoggedIn to false
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        isLoggedIn = false
    }
}
