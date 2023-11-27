//
//  HistoryViewModel.swift
//  SummaryDemo
//
//  Created by gwl-42 on 25/11/23.
//

import SwiftUI
import Combine

class HistoryViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.org/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.savePostsToCoreData(posts)
                print("PostList", posts)
            })
            .store(in: &cancellables)
    }
    
    private func savePostsToCoreData(_ posts: [Post]) {
        let viewContext = PersistenceController.shared.container.viewContext
        
        for post in posts {
            let postEntity = Item(context: viewContext)
            postEntity.title = post.title
            postEntity.content = post.content
        }
        do {
            try viewContext.save()
            print("Data saved to Core Data")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}
