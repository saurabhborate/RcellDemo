//
//  CarInfoCell.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 02/04/22.
//

import UIKit
import SDWebImage
class CarInfoCell: UICollectionViewCell {
    @IBOutlet var imgCar : UIImageView!
    @IBOutlet var btnReserveCar : UIButton!
    @IBOutlet var lbl : UILabel!
    
    func configureCell(vehicle: VehicleDetail ) -> Self{
        self.lbl.text = "\(vehicle.id ?? 0)"
        
        self.imgCar.sd_setImage(with: URL(string: vehicle.vehiclePicAbsoluteURL ?? ""), placeholderImage: nil)
        return self
    }
}
