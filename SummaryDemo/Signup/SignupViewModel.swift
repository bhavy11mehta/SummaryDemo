//
//  SignupViewModel.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var userSignup = SignUpModel(firstname: "", lastname: "", email: "", password: "")
    @Published var validationManager = ValidationManager()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    // Function to handle login button tap
    func signUpButtonTapped() {
        if !validationManager.isValidName(name: userSignup.firstname) {
            showAlert = true
            alertMessage = "First name should be at least 2 characters"
        } else if !validationManager.isValidName(name: userSignup.lastname) {
            showAlert = true
            alertMessage = "Last name should be at least 2 characters"
        } else if !validationManager.isValidEmail(email: userSignup.email) {
            showAlert = true
            alertMessage = "Enter a valid email"
        } else if !validationManager.isValidPassword(password: userSignup.password) {
            showAlert = true
            alertMessage = "Password should be at least 6 characters"
        } else {
            showAlert = false
        }
    }
    
}
