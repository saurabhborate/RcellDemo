//
//  ViewController.swift
//  RidecellDemo
//
//  Created by Saurabh Borate on 01/04/22.
//

import UIKit
import MapKit
class DashBoardVC: UIViewController {

    @IBOutlet var mapView: MKMapView!
//    var arrLocation : LocationList?
    
    let viewModel = VehiclesVM();
    @IBOutlet var CarCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getVehiclesData()
        // Do any additional setup after loading the view.
     
        
        
        
    }

    func updateMapFocus(SelectedCarIndex: IndexPath){
        self.mapView.centerCoordinate = self.mapView.annotations[SelectedCarIndex.row].coordinate
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    override func viewDidAppear(_ animated: Bool) {

        var pins : [MKPointAnnotation] = []

        viewModel.p_loactions.forEach { locationX in
            let addAnotation = MKPointAnnotation()
            addAnotation.title = locationX.vehicleType ?? "Unknown"
            addAnotation.coordinate = CLLocationCoordinate2D(latitude: locationX.lat ?? 0.0, longitude: locationX.lng ?? 0.0)
            
            pins.append(addAnotation)
        
            self.mapView.centerCoordinate = pins[0].coordinate
        }
        
        self.mapView.addAnnotations(pins)
        self.CarCollectionView.reloadData()
    }

}

extension DashBoardVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.p_loactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarInfoCell", for: indexPath) as! CarInfoCell
        
      
        let vehicle = viewModel.p_loactions[indexPath.row]
         return cell.configureCell(vehicle: vehicle)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: self.view.bounds.width, height: self.CarCollectionView.bounds.height)
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = self.CarCollectionView.contentOffset
        visibleRect.size = self.CarCollectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = self.CarCollectionView.indexPathForItem(at: visiblePoint) else { return }

        self.updateMapFocus(SelectedCarIndex: indexPath)
    }
}
