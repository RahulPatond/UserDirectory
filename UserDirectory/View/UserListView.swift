//
//  UserListView.swift
//  UserDirectory
//
//  Created by Rahul Patond on 17/02/26.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject private var viewModel = UserListViewModel()
  
    var body: some View {
        
        NavigationStack {
            
            List(viewModel.users) { user in
                
                VStack{
                    Text(user.name)
                    Text(user.email)
                }
            }
            .navigationTitle("Users")
        }
        .task {
            await viewModel.fetchUsers()
        }

    }
}
