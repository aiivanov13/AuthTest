//
//  AppleSingIn.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation
import AuthenticationServices

@MainActor
final class AppleAuth {
//    private var dispatch: ((AuthAction) -> Void)?
//    
//    init(dispatch: @escaping (AuthAction) -> Void) {
//        self.dispatch = dispatch
//        super.init()
//    }
    
    static func signIn(dispatch: @escaping (AuthAction) -> Void) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        let delegate = AppleAuthDelegate(dispatch: dispatch)
        controller.delegate = delegate
        controller.presentationContextProvider = delegate
        controller.performRequests()
        AppleAuthDelegateHolder.shared.delegate = delegate
    }
}

final class AppleAuthDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let dispatch: (AuthAction) -> Void
    
    init(dispatch: @escaping (AuthAction) -> Void) {
        self.dispatch = dispatch
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = User(id: credential.user, name: credential.fullName?.givenName, email: credential.email)
            dispatch(.success(user))
        } else {
            dispatch(.failure("Не удалось получить credential"))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dispatch(.failure(error.localizedDescription))
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}

private final class AppleAuthDelegateHolder {
    @MainActor static let shared = AppleAuthDelegateHolder()
    var delegate: AppleAuthDelegate?
    private init() {}
}

//extension AppleAuth: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let user = User(id: credential.user, name: credential.fullName?.givenName, email: credential.email)
//            dispatch?(.success(user))
//        } else {
//            dispatch?(.failure("Не удалось получить credential"))
//        }
//    }
//    
//    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        dispatch?(.failure(error.localizedDescription))
//    }
//    
//    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        UIApplication.shared.windows.first { $0.isKeyWindow }!
//    }
//}
