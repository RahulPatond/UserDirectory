//
//  UserListViewModel.swift
//  UserDirectory
//
//  Created by Rahul Patond on 17/02/26.
//

import Foundation

protocol UserService {
    func fetchUser() async throws -> [User]
}

final class RemoteUserService: UserService {
    func fetchUser() async throws -> [User] {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { throw URLError(.badURL)
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([User].self, from: data)
    }

}

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
    }
    
    func fetchUsers() async  {
        
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await service.fetchUser()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
