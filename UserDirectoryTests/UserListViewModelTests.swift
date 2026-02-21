//
//  UserListViewModelTests.swift
//  UserDirectoryTests
//
//  Created by Rahul Patond on 21/02/26.
//

import XCTest
@testable import UserDirectory


final class MockUserService: UserService {
    
    var users: [User] = []
    var shouldThrowError = false
    
    func fetchUser() async throws -> [UserDirectory.User] {
        
        
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        
        return users
    }
}

@MainActor
final class UserListViewModelTests: XCTestCase {

    func testFetchUserSuccess() async {
        
        
        let mockService = MockUserService()
        
        let mockUser = [
            User(id: 1, name: "rahul", email: "rahul@mail.com"),
            User(id: 1, name: "rahul", email: "rahul@mail.com"),
            User(id: 1, name: "rahul", email: "rahul@mail.com")
        ]
        
        mockService.users = mockUser
        
        let viewModel = UserListViewModel(service: mockService)
        await viewModel.fetchUsers()
        
        XCTAssertEqual(viewModel.users, mockUser)
        XCTAssertNil(viewModel.errorMessage, "error message should be nil")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    
    func testFetchUsersfailure() async {
        
        let mockService = MockUserService()
        
        mockService.shouldThrowError = true
        
        let viewModel = UserListViewModel(service: mockService)
        
        await viewModel.fetchUsers()
        
        XCTAssertTrue(viewModel.users.isEmpty, "users should be emplty")
        XCTAssertNotNil(viewModel.errorMessage, "error message should not be nil")
        XCTAssertFalse(viewModel.isLoading)
    }
}
