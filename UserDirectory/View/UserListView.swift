//
//  UserListView.swift
//  UserDirectory
//
//  Created by Rahul Patond on 17/02/26.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject private var viewModel: UserListViewModel
    
    init() {
        let service = RemoteUserService()
        _viewModel = StateObject(wrappedValue: UserListViewModel(service: service))
    }
    
    var body: some View {
        
        NavigationStack {
            
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                        .font(.subheadline)
                }
            }
            .navigationTitle("User")
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}
