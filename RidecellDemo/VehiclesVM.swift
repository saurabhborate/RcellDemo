//
//  vcViewModel.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 02/04/22.
//

import Foundation

class VehiclesVM {
    
    
    var p_loactions : VehicleList = []
    
    func getVehiclesData()  {
  
        var locations : VehicleList = []
        let decoder = JSONDecoder()

        do {
             locations = try decoder.decode(VehicleList.self, from: jsonString.data(using: .utf8)!)
            self.p_loactions = locations
            
        } catch {
           print("Unable to parse response")
        }
        
    }
    
}
