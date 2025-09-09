//
//  Auth.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation

final class AuthModule {
    static func signIn(_ type: AuthProviderType, dispatch: @escaping (AuthAction) -> Void) {
        switch type {
        case .apple:
            AppleAuth.shared.signIn(dispatch: dispatch)
        case .google:
            dispatch(.failure("Авторизация google не реализована"))
        case .email:
            dispatch(.failure("Авторизация email не реализована"))
        case .phone:
            dispatch(.failure("Авторизация phone не реализована"))
        }
    }
}
