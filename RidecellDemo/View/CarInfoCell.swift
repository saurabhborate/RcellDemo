//
//  CarInfoCell.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 02/04/22.
//

import UIKit
import SDWebImage
class CarInfoCell: UICollectionViewCell {
    @IBOutlet var imgVehicle : UIImageView!
    @IBOutlet var btnReserveCar : UIButton!
    @IBOutlet var lblVehicleDetail : UILabel!
    
    func configureCell(vehicle: VehicleDetail ) -> Self{
        self.lblVehicleDetail.text = "\(vehicle.id ?? 0)"
        self.imgVehicle.sd_setImage(with: URL(string: vehicle.vehiclePicAbsoluteURL ?? ""), placeholderImage: nil)
        return self
    }
}
