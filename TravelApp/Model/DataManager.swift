//
//  DataManager.swift
//  TravelApp
//
//  Created by Amit Mathur on 05/04/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DataManager {
    //MARK: - POST METHOD WITH PARAMTERS ONLY -
    class func postAPIWithParameters(urlString:String,jsonString:[String: AnyObject] ,success: @escaping (AnyObject) -> Void,failure: @escaping(NSError)  -> Void) {
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            Alamofire.request(urlString, method: .post, parameters: jsonString).responseJSON {
                response in
                switch response.result {
                case .success:
                    ActivityIndicator.shared.hide()
                    if (response.response?.statusCode == 200) {
                        if let value = response.result.value {
                            success(value as AnyObject)
                        }
                    } else if (response.response?.statusCode == 203) {
                        //Non-authoritative Information
                    } else  if (response.response?.statusCode == 403) {
                       // Forbidden
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? [String : Any] {
                            if let msg = key["msg"] as? String {
                                showAlert(KAlertTitle, msg)
                            }
                        }
                    } else {
                        let value = response.value as? [String:Any]
                        if let key = value!["data"] as? [String : Any] {
                            if let msg = key["msg"] as? String {
                            showAlert(KAlertTitle, msg)
                            }
                        } else if let message = value?["data"] as? String {
                            self.showAlert(KAlertTitle, message)
                        }
                    }
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                }
            }
        }
        else {
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
    }
    //MARK:- GET METHOD WITH HEADER
    class func getAPIWithHeader(urlString:String,header : [String : AnyObject], success: @escaping (AnyObject) -> Void,failure: @escaping(NSError)  -> Void) {
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            let header :String = header[AppKey.AuthorizationKey] as! String
            var headers = HTTPHeaders()
            headers = ["Auth-token": header]
            Alamofire.request(urlString, method: .get , headers: headers).responseJSON {
                response in
                switch response.result {
                case .success:
                    ActivityIndicator.shared.hide()
                    if (response.response?.statusCode == 200) {
                        if let value = response.result.value {
                            success(value as AnyObject)
                        }
                    } else if (response.response?.statusCode == 403) {
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String{
                            showAlert(KAlertTitle, key)
                        }
                    }  else {
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String {
                            showAlert(KAlertTitle, key)
                        }
                    }
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                }
            }
        }
        else {
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
    }
    //MARK: - GET METHOD WITH PARAMETERS ONLY -
    class func getAPIWithParameters(urlString:String,jsonString:[String: AnyObject] ,success: @escaping (AnyObject) -> Void,failure: @escaping(NSError)  -> Void){
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            let header :String = jsonString[AppKey.AuthorizationKey] as! String
            var headers = HTTPHeaders()
            headers = ["Auth-token": header]
            Alamofire.request(urlString, method: .get , headers: headers).responseJSON {
                response in
                ActivityIndicator.shared.hide()
                switch response.result {
                case .success:
                    if (response.response?.statusCode == 200) {
                        if let value = response.result.value {
                            success(value as AnyObject)
                        }
                    } else if (response.response?.statusCode == 403){
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String {
                            showAlert(KAlertTitle, key)
                        }
                    } else {
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String {
                            showAlert(KAlertTitle, key)
                        }
                    }
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                }
            }
        }
        else {
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
    }
    
    //MARK: - POST METHOD WITH HEADER AND PARAMETERS -
    class func postAPIWithHeaderAndParameters(urlString:String,jsonString:[String: AnyObject],header : [String : AnyObject] ,success: @escaping (AnyObject) -> Void,failure: @escaping(NSError)  -> Void) {
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            let header :String = header[AppKey.AuthorizationKey] as! String
            var headers = HTTPHeaders()
            headers = ["Auth-token": header]
            Alamofire.request(urlString, method: .post, parameters: jsonString, headers: headers).responseJSON {
                response in
                switch response.result {
                case .success:
                    print(response)
                    ActivityIndicator.shared.hide()
                    if (response.response?.statusCode == 200) {
                        if let value = response.result.value {
                            success(value as AnyObject)
                        }
                    } else  if (response.response?.statusCode == 403){
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String{
                            showAlert(KAlertTitle, key)
                        }
                    } else {
                        let value = response.result.value as? [String:Any]
                        if let key = value!["data"] as? String{
                            showAlert(KAlertTitle, key)
                        }
                    }
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                }
            }
        }
        else {
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
    }
    //MARK: - MULTIPART POST METHOD WITH  PARAMETERS -
    class func postMultipartDataWithParameters(urlString:String,imageData:[String:Data],params:[String:AnyObject],success: @escaping (AnyObject) -> Void,failure: @escaping(Error)  -> Void) {
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            let url = try! URLRequest.init(url: urlString, method: .post, headers: nil)
            Alamofire.upload(multipartFormData: { (formdata) in
                for (key, value) in params {
                    formdata.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue).rawValue)!, withName: key)
                }
                for (key,value) in imageData{
                    formdata.append(value, withName: key, fileName: "a.jpeg", mimeType: "image/jpeg")
                }
            }, with: url) { (encodingResult) in
                switch encodingResult{
                case .success(let upload,_,_):
                    upload.responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case .success(_):
                            if (response.response?.statusCode == 200) {
                                if let value = response.result.value {
                                    success(value as AnyObject)
                                }
                            } else {
                                ActivityIndicator.shared.hide()
                                showAlert(KAlertTitle, KErrorResponse)
                            }
                            break
                        case .failure(let error):
                            ActivityIndicator.shared.hide()
                            showAlert(KAlertTitle, kUnKnownError)
                            print(error)
                            break
                        }
                    })
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                    break
                }
            }
        }
        else{
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
        
    }
    class func postMultipartDataWithHeaderAndParameters(urlString:String,imageData:[String:Data],params:[String:AnyObject],header:[String:AnyObject],success: @escaping (AnyObject) -> Void,failure: @escaping(Error)  -> Void) {
        if let networkObj = NetworkReachabilityManager(), networkObj.isReachable {
            let header :String = header[AppKey.AuthorizationKey] as! String
            var headers = HTTPHeaders()
            headers = ["Auth-token": header]
            
            let url = try! URLRequest.init(url: urlString, method: .post, headers: headers)
            Alamofire.upload(multipartFormData: { (formdata) in
                for (key, value) in params {
                    formdata.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue).rawValue)!, withName: key)
                }
                for (key,value) in imageData{
                    formdata.append(value, withName: key, fileName: "a.jpeg", mimeType: "image/jpeg")
                }
            }, with: url) { (encodingResult) in
                switch encodingResult{
                case .success(let upload,_,_):
                    upload.responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case .success(_):
                            if (response.response?.statusCode == 200) {
                                if let value = response.result.value {
                                    success(value as AnyObject)
                                }
                            } else {
                                ActivityIndicator.shared.hide()
                                showAlert(KAlertTitle, KErrorResponse)
                            }
                            break
                        case .failure(let error):
                            ActivityIndicator.shared.hide()
                            showAlert(KAlertTitle, kUnKnownError)
                            print(error)
                            break
                        }
                    })
                    break
                case .failure(let error):
                    ActivityIndicator.shared.hide()
                    showAlert(KAlertTitle, kUnKnownError)
                    print(error)
                    break
                }
            }
        }
        else{
            ActivityIndicator.shared.hide()
            showAlert(KAlertTitle, KInternetConnection)
        }
        
    }
    
    
    //MARK: - ALERT METHOD CUSTUM -
    class func showAlert(_ title : String,_ message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: KOk, style: .default, handler: nil))
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil){
            topVC = topVC!.presentedViewController
        }
        topVC?.present(alert, animated: true, completion: nil)
    }
}
