//
//  APIService.swift
//  appleAlbum
//
//  Created by Webber Wong on 10/3/2022.
//

import Foundation

enum ApiError: Error {
    case parseJsonFailed
    case unexpected(code: Int)
}

extension ApiError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .parseJsonFailed:
            return "json failed"
        case .unexpected(code: _):
            return "An unexpected error occured."
        }
    }
}

enum URLError: Error {
    case unexpected(code: Int)
}

extension URLError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unexpected(code: _):
            return "An unexpected URL occured."
        }
    }
}

class ApiService {
    enum RequestType: String {
        case POST
        case GET
        case PUT
        case DELETE
    }
    public static func postAlbumDict(url: String, completionHandler: @escaping ([String:Any]?, Error?) -> Void){
        guard let url = URL(string: url) else {
            completionHandler(nil, URLError.unexpected(code: -1))
            return
        }
        ApiRequest(url: url, method: .POST, contentType: "application/json; charset=utf-8", parameters: [:]) { (dict, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard dict != nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(dict, nil)
        }
    }
}

extension ApiService {
    fileprivate static func ApiRequest(url: URL, method: RequestType, contentType: String , parameters: [String:Any]?, completionHandler: @escaping ([String:Any]?, Error?) -> Void){
        makeRequest(url: url, method: method, contentType: contentType, parameters: parameters) { (data, error) in
            guard let obj = data, let dict = obj as? [String:Any] else{
                completionHandler(nil, error)
                return
            }
            completionHandler(dict, nil)
        }
    }
    fileprivate static func makeRequest(url: URL, method: RequestType, contentType: String, parameters: [String:Any]?, completionHandler: @escaping (Any?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .POST{
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
            if let param = parameters{
                let jsonData = try? JSONSerialization.data(withJSONObject: param)
                request.httpBody = jsonData
            }
        }
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                        completionHandler(json, nil)
                    }
                } catch{
                    DispatchQueue.main.async {
                        completionHandler(nil, ApiError.parseJsonFailed)
                    }
                }
            }
            else if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
            else{
                DispatchQueue.main.async {
                    completionHandler(nil, ApiError.unexpected(code: -1))
                }
            }
        }
        task.resume()
    }
}
