//
//  TravelObjects.swift
//  TravelApp
//
//  Created by Amit Mathur on 18/04/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import Foundation

class Packages {
    var packageId: String = ""
    var packageName: String = ""
    var packageCode: String = ""
    var packageDescription: String = ""
    var duration: String = ""
    var country: String = ""
    var state: String = ""
    var city: String = ""
    var location: String = ""
    var rating: String = ""
    var status: String = ""
    var price: String = ""
    var image: String = ""
    var favourite : String = ""

    init(packageId: String, packageName: String, packageCode: String, packageDescription: String, duration: String,country: String, state: String, city: String, location: String, rating: String,status: String, price:String, image:String, favourite : String) {
        self.packageId = packageId
        self.packageName = packageName
        self.packageCode = packageCode
        self.packageDescription = packageDescription
        self.duration = duration
        self.country = country
        self.state = state
        self.city = city
        self.location = location
        self.rating = rating
        self.status = status
        self.price = price
        self.image = image
        self.favourite = favourite
 }
}

class PackageItinerary{
    var itiId: String = ""
    var packageId: String = ""
    var city: String = ""
    var day: String = ""
    var place : String = ""
    var itiDesc : String = ""
    var itiImage: String = ""
    var itiLink : String = ""
    
    init(itiId: String, packageId: String, city: String, day: String, place : String, itiDesc: String, itiImage: String, itiLink : String) {
        self.itiId = itiId
        self.packageId = packageId
        self.city = city
        self.day = day
        self.place = place
        self.itiDesc = itiDesc
        self.itiImage = itiImage
        self.itiLink = itiLink
       
    }
}

class Cities {
    var id : String = ""
    var country : String = ""
    var name : String = ""
    init(cityId: String, cityCountry : String, cityName: String) {
        self.id = cityId
        self.country = cityCountry
        self.name = cityName
    }
}

class Country {
    var code : String = ""
    var name : String = ""
    var origin : String = ""
    init(countryCode : String, countryName : String, countryOrigin : String) {
        self.code = countryCode
        self.name = countryName
        self.origin = countryOrigin
    }
}

class Profile {
    var userId : String = ""
    var userType : String = ""
    var email : String = ""
    var userName : String = ""
    var password : String = ""
    var status : String = ""
    var dateOfBirth : String = ""
    var image : String = ""
    var title : String = ""
    var firstName : String = ""
    var lastName : String = ""
    var address : String = ""
    var state : String = ""
    var city : String = ""
    var pinCode : String = ""
    var countryCode : String = ""
    var countryName : String = ""
    var phone : String = ""

    init(userId:String, userType : String, email:String, userName:String, password:String, status:String, dateOfBirth:String, image:String, title:String, firstName:String, lastName:String, address:String, state:String, city:String, pinCode:String, countryCode:String, countryName:String, phone:String) {
        self.userId = userId
        self.userType = userType
        self.email = email
        self.userName = userName
        self.password = password
        self.status = status
        self.dateOfBirth = dateOfBirth
        self.image = image
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.state = state
        self.city = city
        self.pinCode = pinCode
        self.countryCode = countryCode
        self.countryName = countryName
        self.phone = phone

    }
}
class BookingEntries {
    static let shared = BookingEntries()
    var userId: String = ""
    var travelDate: String = ""
    var packageID: String = ""
    var noOfAdults: String = ""
    var noOfChildren: String = ""
    var hotelType: String = ""
    var name: String = ""
    var email:String = ""
    var passportNumber = ""
    var dateOfBirth = ""
    private init() {}
    func saveData() {
        
    }
    
}
