//
//  AuthAction.swift
//  AuthModule
//
//  Created by Александр Иванов on 08.09.2025.
//

import Foundation

public enum AuthProviderType {
    case apple
    case google
    case email
    case phone
}

public enum AuthAction {
    case signIn(provider: AuthProviderType, credentials: [String: Any]? = nil)
    case success(User)
    case failure(String)
    case setLoading(Bool)
    case signOut
}
