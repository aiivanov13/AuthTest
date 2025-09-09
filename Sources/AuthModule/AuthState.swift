//
//  AuthState.swift
//  AuthModule
//
//  Created by Александр Иванов on 08.09.2025.
//

import Foundation

public struct User: Equatable {
    public let id: String
    public let name: String?
    public let email: String?
}

public struct AuthState {
    public var user: User?
    public var isLoading: Bool = false
    public var error: String?
}
