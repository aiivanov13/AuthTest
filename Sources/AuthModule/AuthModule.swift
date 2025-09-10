//
//  Auth.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation

@MainActor
public final class AuthModule {
    private static var appleDelegate: AppleSignIn.AppleDelegate?
    
    public static func signIn(_ type: AuthType, dispatch: @escaping (ReturnedType) -> Void) {
        switch type {
        case .apple:
            let delegate = AppleAuthDelegate(dispatch: dispatch) {
                AuthModule.appleDelegate = nil
            }
            
            appleDelegate = delegate
            AppleSignIn.signIn(delegate: delegate)
        case .google(let serverClientID):
            GoogleSignIn.signIn(
                dispatch: dispatch,
                serverClientID: serverClientID
            )
        case .email:
            dispatch(.failure("Авторизация email не реализована"))
        case .phone:
            dispatch(.failure("Авторизация phone не реализована"))
        }
    }
}
