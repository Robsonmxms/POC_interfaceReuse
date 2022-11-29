//
//  Model.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.
//

import UIKit

struct Model {
    var frontRG: UIImage?
    var backRG: UIImage?
    var residenceProof: UIImage?
    var petSpace: UIImage?
    var email: String?
    var phone: String?
    var text: String?
    var isAuthorized: Bool?
}

struct NavigationForm {

    static func navigation(form: Form) -> UIViewController {
        switch form {
        case .rgData:
            return ViewController(.rgData)
        case .petLocal:
            return ViewController(.petLocal)
        case .userContact:
            return ViewController(.userContact)
        case .textToONG:
            return ViewController(.textToONG)
        case .authorized:
            return ViewController(.authorized)
        }
    }
}

enum Form {
    case rgData
    case petLocal
    case userContact
    case textToONG
    case authorized
}
