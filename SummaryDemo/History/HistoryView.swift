//
//  HistoryView.swift
//  SummaryDemo
//
//  Created by gwl-42 on 24/11/23.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = HistoryViewModel()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        List {
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    Text("Title:- \(item.title ?? "")")
                    Text("description:- \(item.content ?? "")")
                }
            } .onDelete(perform: deleteItems)
        }.onAppear() {
            if items.count == 1 {
                viewModel.fetchPosts()
            }
        }
        .navigationBarTitle("History")
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
