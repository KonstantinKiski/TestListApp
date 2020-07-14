//
//  NetworkingManagerError.swift
//  TestApp
//
//  Created by Константин Киски on 14.07.2020.
//  Copyright © 2020 Константин Киски. All rights reserved.
//

struct NetworkManagerError : Error {
    
    enum NetworkManagerErrorKind {
        case wrongURL
        case serverIsDown
        case noInternet
        case httpClient(httpCode : Int)
        case timedOut
        case responce
        case parsing
        case unknown
        
        var isConnectivityError : Bool {
            switch self {
            case .noInternet, .timedOut, .serverIsDown, .wrongURL, .unknown:
                return true
            case .httpClient(let httpCode):
                if httpCode == 401 { return true}
                return false
            default:
                return false
            }
        }
        
        var localizedDescription : String {
            switch self {
            case .noInternet, .timedOut, .serverIsDown, .wrongURL, .unknown:
                return "Проверьте подключение к интернету и повторите попытку."
            case .httpClient(let httpCode):
                if httpCode == 401 { return "Для того чтобы увидеть содержимое авторизуйтесь."}
                return ""
            default:
                return "Проверьте подключение к интернету и повторите попытку."
            }
            
        }
    }
    
    let kind : NetworkManagerErrorKind
    private var _titleLocalizedDescription : String? = ""
    var titleLocalizedDescription : String? {
        get {
            if _titleLocalizedDescription?.isEmpty ?? true {
                return "Не удалось загрузить данные"
            }
            return _titleLocalizedDescription
        }
        set {
            _titleLocalizedDescription = newValue
        }
    }
    
    private var _textLocalizedDescription : String? = ""
    var textLocalizedDescription: String? {
        get {
            if _textLocalizedDescription?.isEmpty ?? true {
                return kind.localizedDescription
            }
            return _textLocalizedDescription
        }
        set {
            _textLocalizedDescription = newValue
        }
    }
    var error : Error? = nil
    
    init(kind : NetworkManagerErrorKind) {
        self.kind = kind
    }
    
    init(kind : NetworkManagerErrorKind, textLocalizedDescription : String? = nil) {
        self.kind = kind
        self.textLocalizedDescription = textLocalizedDescription
    }
    
    init(kind : NetworkManagerErrorKind, error : Error? = nil) {
        self.kind = kind
        self.error = error
    }
}
