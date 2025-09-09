//
//  AppleSingIn.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation
import AuthenticationServices

public final class AppleAuth: NSObject {
    public static var shared: AppleAuth { AppleAuth() }
    private var dispatch: ((AuthAction) -> Void)?
    
    private override init() {
        super.init()
    }
    
    func signIn(dispatch: @escaping (AuthAction) -> Void) {
        self.dispatch = dispatch

        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension AppleAuth: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = User(id: credential.user, name: credential.fullName?.givenName, email: credential.email)
            dispatch?(.success(user))
        } else {
            dispatch?(.failure("Не удалось получить credential"))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dispatch?(.failure(error.localizedDescription))
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}
