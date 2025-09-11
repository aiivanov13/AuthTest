//
//  AuthData.swift
//  AuthModule
//
//  Created by Александр Иванов on 08.09.2025.
//

import Foundation

public protocol AuthData: Equatable { }

public struct EmailAuthData: AuthData {
    public var email: String
    public var password: String
}

public struct PhoneAuthData: AuthData {
    public var phone: String
}

public struct SocialAuthData: AuthData {
    public var idToken: String
    public var email: String
}
