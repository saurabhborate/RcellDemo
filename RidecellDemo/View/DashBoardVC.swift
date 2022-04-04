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
    
    let viewModel = VehiclesVM()
    
    @IBOutlet var CarCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getVehiclesData()
    }
    
    
    func updateMapFocus(SelectedCarIndex: IndexPath){
        if let centerCoordinate =  self.viewModel.getCenterCoordinateFromIndexPath(SelectedCarIndex){
            self.mapView.centerCoordinate = centerCoordinate
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        var pins : [VehicleAnnotation] = []
        
        viewModel.vehicleList.forEach { locationX in
            let addAnotation = VehicleAnnotation()
            addAnotation.title = locationX.vehicleMake ?? ""
            addAnotation.subtitle = "\(locationX.id ?? 0)"
            addAnotation.coordinate = CLLocationCoordinate2D(latitude: locationX.lat ?? 0.0, longitude: locationX.lng ?? 0.0)
            addAnotation.identifier = locationX.id
            pins.append(addAnotation)
            // As per requirment , will zoom to the first vehicle’s location
            self.mapView.centerCoordinate = pins[0].coordinate
        }
        
        self.mapView.addAnnotations(pins)
        self.CarCollectionView.reloadData()
        self.CarCollectionView.performBatchUpdates(nil) { result in
            let indexPath = IndexPath(item: 0, section: 0)
            //As we are showing first vehicle’s location in same way we will make sure that we will show first vehicle’s details in collection view
            self.scrollToItem(indexPath: indexPath)
        }
    }
    
}
//Here we keep map view related delagates and functions.
extension DashBoardVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is VehicleAnnotation else { return nil }
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
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // first we ensure that it really is an VehicleAnnotation
        if let vehicleAnnotation = view.annotation as? VehicleAnnotation , vehicleAnnotation.identifier != nil {
            if let index =  self.viewModel.getIndexFromIdentifier(vehicleAnnotation.identifier!){
                let indexPath = IndexPath(item: index, section: 0)
                scrollToItem(indexPath: indexPath)
                updateMapFocus(SelectedCarIndex: indexPath)
            }
        }
    }
}
//Here we keep collection view related delagates and functions.
extension DashBoardVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.vehicleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarInfoCell", for: indexPath) as! CarInfoCell
        
        
        let vehicle = viewModel.vehicleList[indexPath.row]
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
    func scrollToItem(indexPath: IndexPath){
        self.CarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
