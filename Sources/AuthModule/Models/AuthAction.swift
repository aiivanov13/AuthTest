//
//  AuthAction.swift
//  AuthModule
//
//  Created by Александр Иванов on 08.09.2025.
//

import Foundation

public enum AuthType {
    case apple
    case google(serverClientID: String)
    case email(EmailAuthData)
    case phone(PhoneAuthData)
}

public enum ReturnedType {
    case setLoading(Bool)
    case success(any AuthData)
    case failure(String)
}
