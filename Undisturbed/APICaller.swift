//
//  APICaller.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/5/23.
//

import Foundation
import FirebaseAuth

struct APICaller {
    static let shared = APICaller()
    
    enum APIError: Error {
        case failedToGetData
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error == nil)
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            guard let result, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            completion(.success(result))
            
        }
    }
}
