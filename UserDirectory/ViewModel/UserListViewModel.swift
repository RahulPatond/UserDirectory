//
//  UserListViewModel.swift
//  UserDirectory
//
//  Created by Rahul Patond on 17/02/26.
//

import Foundation


protocol UserService {
    func fetchUsers() async throws
}

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func fetchUsers() async  {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            users = decodedUsers
            
        } catch {
            print("Error occured during fetch -- \(error)")
        }
    }
}
