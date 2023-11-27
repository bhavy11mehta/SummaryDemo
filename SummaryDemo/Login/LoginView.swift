//
//  LoginView.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showSignUpView: Bool = false
    @State private var showHomeView: Bool = false
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $viewModel.userLogin.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                
                SecureField("Password", text: $viewModel.userLogin.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                Button(action: {
                    viewModel.loginButtonTapped()
                    if !viewModel.showAlert {
                        sessionManager.login()
                        showHomeView = true
                    }
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
                Button(action: {
                    showSignUpView = true
                }) {
                    Text("Don't have an account? Sign Up")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.blue)
                }
                Spacer()
            }.onAppear() {
                showSignUpView = false
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Login")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Validation Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            NavigationLink(destination: SignupView(), isActive: $showSignUpView) {
                EmptyView()
            }
            NavigationLink(destination: HomeView(), isActive: $showHomeView) {
                EmptyView()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
