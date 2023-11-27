//
//  SignupView.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI

struct SignupView: View {
    @State var showHomeView : Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var viewModel = SignupViewModel()
    
    var body: some View {
        ScrollView {
        VStack {
            TextField("First name", text: $viewModel.userSignup.firstname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            TextField("Last name", text: $viewModel.userSignup.lastname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            TextField("Email", text: $viewModel.userSignup.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            SecureField("Password", text: $viewModel.userSignup.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            Button(action: {
                viewModel.signUpButtonTapped()
                if !viewModel.showAlert {
                    sessionManager.login()
                    showHomeView = true
                }
            }) {
                Text("Signup")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
            Button(action: {
                // Navigate to LoginView
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Already Registered? Login")
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }.onAppear() {
            showHomeView = false
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("SignUp")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Validation Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        NavigationLink(destination: HomeView(), isActive: $showHomeView) {
            EmptyView()
        }
    }
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
