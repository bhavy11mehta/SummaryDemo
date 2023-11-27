//
//  ValidationManager.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import Foundation

class ValidationManager: ObservableObject {
    
    // Email validation function
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Password validation function
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6
    }
    
    // Name validation function
    func isValidName(name: String) -> Bool {
        return name.count >= 2
    }
    
}
