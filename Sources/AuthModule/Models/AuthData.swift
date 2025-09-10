//
//  AuthData.swift
//  AuthModule
//
//  Created by Александр Иванов on 08.09.2025.
//

import Foundation

public protocol AuthData: Equatable { }

public struct EmailAuthData: AuthData {
    var email: String
    var password: String
}

public struct PhoneAuthData: AuthData {
    var phone: String
}

public struct SocialAuthData: AuthData {
    var idToken: String
    var email: String
}
