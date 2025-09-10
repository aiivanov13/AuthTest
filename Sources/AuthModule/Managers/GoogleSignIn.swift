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
    static func signIn(dispatch: @escaping (ReturnedType) -> Void, serverClientID: String) {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .windows
            .first?
            .rootViewController else { return }
        
        
        let signInConfig = GIDConfiguration(
            clientID: "996421999255-9ne3nvgg87f3otmu1rckkbivs5sdtnbo.apps.googleusercontent.com",
            serverClientID: "996421999255-8q2v9lsm9lv5qutbfa7g6r6ut2oht2p0.apps.googleusercontent.com"
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
