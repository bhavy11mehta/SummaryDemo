//
//  HomeViewModel.swift
//  SummaryDemo
//
//  Created by gwl-42 on 25/11/23.
//

import SwiftUI
import CoreData
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var summary = HomeModel(summaryTitle: "", summaryDecription: "")
    @Published var text: String = ""
    @Published var fileName: String = ""
    @Published var showHistory: Bool = false
    @Published var validationManager = ValidationManager()
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    // Function to handle get summary button tap
    func getSummaryButtonTapped() {
        if !validationManager.isValidName(name: summary.summaryTitle) {
            showAlert = true
            alertMessage = "Summary title should be at least 2 characters"
        } else if !validationManager.isValidName(name: summary.summaryDecription) {
            showAlert = true
            alertMessage = "Summary description should be at least 2 characters"
        } else {
            showAlert = false
        }
    }
    
    // Core Data
    func saveData(context: NSManagedObjectContext) {
        let newNote = Item(context: context)
        newNote.title = summary.summaryTitle
        newNote.content = summary.summaryDecription
        
        do {
            try context.save()
            print("save note")
            showHistory = true
        } catch let error as NSError{
            // alert user
            print("No save", error.localizedDescription)
        }
    }
    
    func clearDatabase(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            print("Database cleared")
        } catch {
            print("Failed to clear database: \(error.localizedDescription)")
        }
    }
    
    
}
