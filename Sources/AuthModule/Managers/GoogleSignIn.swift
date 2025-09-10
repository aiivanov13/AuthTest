//
//  GoogleSignIn.swift
//  AuthModule
//
//  Created by Александр Иванов on 10.09.2025.
//

import Foundation
import GoogleSignIn

@MainActor
public final class GoogleSignIn {
    static func signIn(dispatch: @escaping (ReturnedType) -> Void, clientID: String, serverClientID: String) {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows
            .first?
            .rootViewController else { return }
        
        let signInConfig = GIDConfiguration(
            clientID: clientID,
            serverClientID: serverClientID
        )
        GIDSignIn.sharedInstance.configuration = signInConfig
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController
        ) { result, error in
            guard error == nil else {
                dispatch(.failure(error?.localizedDescription ?? ""))
                return
            }
            
            guard let receivedUser = result?.user,
                  let idToken = receivedUser.idToken?.tokenString else {
                dispatch(.failure("Не удалось получить credential"))
                return
            }
            
            let data = SocialAuthData(idToken: idToken, email: receivedUser.profile?.email ?? "")
            
//            dispatch(.setLoading(true))
            dispatch(.success(data))
        }
    }
}
