//
//  APIUrl.swift
//  TravelApp
//
//  Created by Amit Mathur on 05/04/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
//base URL for app
public let baseURL              = "https://pixelsncode.in/webservices/index.php/"
public let imageBaseURL         =   "http://pixelsncode.in/vietnam_travels/extras/custom/Vc8Z7XLsy3773882296/uploads/packages/"

public struct API {
    public static let logIn                   =           baseURL+"auth/login"
    public static let packageDetail           =           baseURL+"tours/details/"
    public static let cities                  =           baseURL+"tours/cities"
    public static let search                  =           baseURL+"tours/search"
    public static let addTraveller            =           baseURL+"user/add_traveller"
    public static let profile                 =           baseURL+"user/get_user_details"
    public static let updateProfile           =           baseURL+"user/profile"
    public static let logOut                  =           baseURL+"auth/ajax_logout"
    public static let changePassword          =           baseURL+"auth/change_password"
    public static let forgotPassword          =           baseURL+"auth/forgot_password"
    public static let termsAndCondition       =           baseURL+"general/terms_and_condition"
    public static let aboutUs                 =           baseURL+"general/about_us"
    public static let register                =           baseURL+"auth/register_on_light_box"
    public static let dashBoard               =           baseURL+"tours/dashboard"
    public static let country                 =           baseURL+"user/get_phone_code_list"
    public static let favrt_package           =           baseURL+"tours/favrt_package"
    public static let unfavrt_packages        =           baseURL+"tours/unfavrt_packages"
}
public let KOk                                =        "Ok"

//Commom Messages
public let KAlertTitle                        =      "TravelApp"
public let kUnKnownError                      =      "Server connection is poor"
public let KInternetConnection                =      "The Internet connection appears to be offline."

public struct AppKey {
    public static let AuthorizationKey = "auth_token"

}
