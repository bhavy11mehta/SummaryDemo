//
//  HomeView.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showPlaceholder: Bool = true
    @State private var showDocumentPicker = false
    @State private var showLogin: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .topLeading) {
                    if showPlaceholder {
                        Text("Select the document from file")
                            .foregroundColor(Color.gray)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .onTapGesture {
                                showPlaceholder = false
                            }
                    }
                    
                    TextEditor(text: $viewModel.text)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 200)
                        .opacity(showPlaceholder ? 0.25 : 1) // Adjust the opacity based on the placeholder state
                        .padding()
                        .onTapGesture {
                            if showPlaceholder {
                                showPlaceholder = false
                            }
                        }
                        .onChange(of: viewModel.text) { newValue in
                            // Show or hide the placeholder based on the text value
                            showPlaceholder = newValue.isEmpty
                        }
                    
                }.border(Color.gray, width: 1)
                    .padding()
                Text(viewModel.fileName)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                Button(action: {
                    viewModel.text = ""
                    showDocumentPicker.toggle()
                }) {
                    Text("Upload Document")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
                .sheet(isPresented: $showDocumentPicker) {
                    DocumentPicker(documentContent: $viewModel.text, selectedFileName: $viewModel.fileName)
                }
                TextField("Enter Summary Title", text: $viewModel.summary.summaryTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                TextField("Enter Summary Decription", text:
                            $viewModel.summary.summaryDecription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                Button(action: {
                    viewModel.getSummaryButtonTapped()
                    if !viewModel.showAlert {
                        viewModel.saveData(context: viewContext)
                    }
                }) {
                    Text("Get Summary")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
                Spacer()
            }.onAppear() {
                viewModel.summary.summaryTitle = ""
                viewModel.summary.summaryDecription = ""
                viewModel.showHistory = false
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Home")
        .navigationBarItems(trailing:
                                Button(action: {
            sessionManager.logout()
            viewModel.clearDatabase(context: viewContext)
            showLogin = true
        }) {
            Text("Logout")
        }
        )
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Validation Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        NavigationLink(destination: HistoryView(), isActive: $viewModel.showHistory) {
            EmptyView()
        }
        NavigationLink(destination: LoginView(), isActive: $showLogin) {
            EmptyView()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
