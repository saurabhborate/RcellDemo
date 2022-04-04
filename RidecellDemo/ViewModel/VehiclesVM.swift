//
//  vcViewModel.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 02/04/22.
//

import Foundation
import CoreLocation

class VehiclesVM {
    var vehicleList : VehicleList = []
    
    func getVehiclesData()  {
        
        var locations : VehicleList = []
        let decoder = JSONDecoder()
        
        do {
            locations = try decoder.decode(VehicleList.self, from: jsonString.data(using: .utf8)!)
            self.vehicleList = locations
            
        } catch {
            print("Unable to parse response")
        }
        
    }
    
    func getIndexFromIdentifier(_ identifier: Int) -> Int?{
        for (index , vehicle) in vehicleList.enumerated(){
            if identifier == vehicle.id{
                return index
            }
        }
        return nil
    }
    func getCenterCoordinateFromIndexPath(_ indexPath: IndexPath) -> CLLocationCoordinate2D?{
        guard let lat = vehicleList[indexPath.row].lat else {
            return nil
        }
        guard let long = vehicleList[indexPath.row].lng else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}