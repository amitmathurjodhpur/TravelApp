//
//  NetworkCall.swift
//  TravelApp
//
//  Created by Amit Mathur on 28/09/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

class APIRequest {
    let method: HTTPMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?

    init(method: HTTPMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    class func showAlert(_ title : String,_ message : String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: KOk, style: .default, handler: nil))
            var topVC = UIApplication.shared.keyWindow?.rootViewController
            while((topVC!.presentedViewController) != nil){
                topVC = topVC!.presentedViewController
            }
            topVC?.present(alert, animated: true, completion: nil)
        }
       
    }
}

enum APIError: Error {
    case invalidURL
    case requestFailed
}

struct APIClient {

    typealias APIClientCompletion = (HTTPURLResponse?, Data?, APIError?) -> Void

    private let session = URLSession.shared
    private let baseURL = URL(string: "https://misterminh.com/webservices/index.php/")!

    func request(_ request: APIRequest, _ completion: @escaping APIClientCompletion) {

        var urlComponents = URLComponents()
        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = baseURL.path
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url?.appendingPathComponent(request.path) else {
            completion(nil, nil, .invalidURL); return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        request.headers?.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.field) }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, .requestFailed); return
            }
            if httpResponse.statusCode == 200 {
                completion(httpResponse, data, nil)
            } else {
                do {
                    let decoded = try JSONSerialization.jsonObject(with: data!, options: [])
                    if let dictFromJSON = decoded as? NSDictionary, let keyValue = dictFromJSON["data"] as? NSDictionary {
                        
                        if let key = keyValue["msg"] as? String {
                            if httpResponse.statusCode == 400 && key == "Incorrect Auth Token!!!" {
                                APIRequest.showAlert(KAlertTitle, key)
                                //need to handle auth token things
                            } else {
                                APIRequest.showAlert(KAlertTitle, key)
                            }
                        } else {
                            APIRequest.showAlert(KAlertTitle, kUnKnownError)
                        }
                        completion(nil, nil, .requestFailed); return
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(nil, nil, .requestFailed); return
                }
            }
      }
        task.resume()
    }
}

