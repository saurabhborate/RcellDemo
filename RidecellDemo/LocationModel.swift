//
//  File.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 01/04/22.
//

import Foundation

typealias VehicleList = [VehicleDetail]

struct VehicleDetail: Codable {
    var id: Int?
    var isActive, isAvailable: Bool?
    var lat: Double?
    var licensePlateNumber: String?
    var lng: Double?
    var pool: String?
    var remainingMileage, remainingRangeInMeters: Int?
    var transmissionMode, vehicleMake, vehiclePic: String?
    var vehiclePicAbsoluteURL: String?
    var vehicleType: String?
    var vehicleTypeID: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "is_active"
        case isAvailable = "isAvailable"
        case lat = "lat"
        case licensePlateNumber = "license_plate_number"
        case lng = "lng"
        case pool = "pool"
        case remainingMileage = "remaining_mileage"
        case remainingRangeInMeters = "remaining_range_in_meters"
        case transmissionMode = "transmission_mode"
        case vehicleMake = "vehicle_make"
        case vehiclePic = "vehicle_pic"
        case vehiclePicAbsoluteURL = "vehicle_pic_absolute_url"
        case vehicleType = "vehicle_type"
        case vehicleTypeID = "vehicle_type_id"
    }
}


