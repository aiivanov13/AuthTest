//
//  Auth.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation

@MainActor
public final class AuthModule {
    private static var appleDelegate: AppleAuth.AppleDelegate?
    
    public static func signIn(_ type: AuthProviderType, dispatch: @escaping (AuthAction) -> Void) {
        switch type {
        case .apple:
            let delegate = AppleAuthDelegate(dispatch: dispatch) {
                AuthModule.appleDelegate = nil
            }
            
            appleDelegate = delegate
            AppleAuth.signIn(delegate: delegate)
        case .google:
            dispatch(.failure("Авторизация google не реализована"))
        case .email:
            dispatch(.failure("Авторизация email не реализована"))
        case .phone:
            dispatch(.failure("Авторизация phone не реализована"))
        }
    }
}
