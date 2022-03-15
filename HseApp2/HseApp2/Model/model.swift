//
//  model.swift
//  HseApp2
//
//  Created by Al Stark on 15.03.2022.
//

import UIKit

struct LoginField{
    var email: String
    var password: String
}


struct ResponseCode {
    var code: Int
}

enum AuthResponse {
    case success, error, noVerify
}
