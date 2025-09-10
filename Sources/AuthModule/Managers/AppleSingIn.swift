//
//  AppleSingIn.swift
//  AuthModule
//
//  Created by Александр Иванов on 09.09.2025.
//

import Foundation
import AuthenticationServices

@MainActor
final class AppleSignIn {
    typealias AppleDelegate = ASAuthorizationControllerDelegate & ASAuthorizationControllerPresentationContextProviding

    static func signIn(delegate: AppleDelegate?) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.presentationContextProvider = delegate
        controller.performRequests()
    }
}

final class AppleAuthDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private let dispatch: (ReturnedType) -> Void
    private let onFinish: () -> Void
    
    init(dispatch: @escaping (ReturnedType) -> Void, onFinish: @escaping () -> Void) {
        self.dispatch = dispatch
        self.onFinish = onFinish
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
        let idTokenData = credential.identityToken,
        let idToken = String(data: idTokenData, encoding: .utf8) {
            let data = SocialAuthData(idToken: idToken, email: credential.email ?? "")

            //            dispatch(.setLoading(true))
            dispatch(.success(data))
        } else {
            dispatch(.failure("Не удалось получить credential"))
        }
        onFinish()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dispatch(.failure(error.localizedDescription))
        onFinish()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)!.windows.first { $0.isKeyWindow }!
    }
}
