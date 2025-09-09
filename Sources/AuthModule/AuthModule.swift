//
//  Auth.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation

public final class AuthModule {
    static var shared: AuthModule { AuthModule() }
    let appleAuth = AppleAuth()
    
    private init() { }
    
    public func signIn(_ type: AuthProviderType, dispatch: @escaping (AuthAction) -> Void) {
        switch type {
        case .apple:
            appleAuth.signIn(dispatch: dispatch)
        case .google:
            dispatch(.failure("Авторизация google не реализована"))
        case .email:
            dispatch(.failure("Авторизация email не реализована"))
        case .phone:
            dispatch(.failure("Авторизация phone не реализована"))
        }
    }
}
