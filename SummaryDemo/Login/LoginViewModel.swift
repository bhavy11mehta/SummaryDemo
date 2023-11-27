//
//  LoginViewModel.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var userLogin = LoginModel(email: "", password: "")
    @Published var validationManager = ValidationManager()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    // Function to handle login button tap
    func loginButtonTapped() {
        if !validationManager.isValidEmail(email: userLogin.email) {
            showAlert = true
            alertMessage = "Enter a valid email"
        } else if !validationManager.isValidPassword(password: userLogin.password) {
            showAlert = true
            alertMessage = "Password should be at least 6 characters"
        } else {
            showAlert = false
        }
    }
}
