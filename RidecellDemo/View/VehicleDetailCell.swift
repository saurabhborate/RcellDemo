//
//  CarInfoCell.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 02/04/22.
//

import UIKit
import SDWebImage
protocol DelegateVehicleDetailsCell {
    func btnReserveCarClicked()
}
class VehicleDetailCell: UICollectionViewCell {
    @IBOutlet var imgVehicle : UIImageView!
    
    @IBOutlet var btnReserveVehicle : UIButton!
    
    @IBOutlet var lblVehicleDetail : UILabel!
    
    var delgate: DelegateVehicleDetailsCell?
    
    func configureCell(vehicle: VehicleDetail ) -> Self{
        self.lblVehicleDetail.text = "\(vehicle.id ?? 0)"
        self.imgVehicle.sd_setImage(with: URL(string: vehicle.vehiclePicAbsoluteURL ?? ""), placeholderImage: nil)
        return self
    }
    @IBAction func btnReserveVehicleAction(_ sender: Any) {
        if let delgate = delgate {
            delgate.btnReserveCarClicked()
        }
    }
}
