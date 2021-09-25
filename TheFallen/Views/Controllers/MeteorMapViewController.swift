//
//  MeteorMapViewController.swift
//  TheFallen
//
//  Created by Munachimso Ugorji on 24/09/2021.
//

import UIKit
import MapKit

class MeteorMapViewController: UIViewController {
    @IBOutlet weak var meteorMapView: MKMapView!
    var viewModel: MeteorMapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpNavigationBarItem()
        self.setUpFavourites()
    }
    
    func setUpMap() {
        guard let vModel = self.viewModel else { return }
        self.title = vModel.getMeteorName()
        if let location = vModel.getLocation() {
            meteorMapView.centerToLocation(location)
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
            meteorMapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region),animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = vModel.getMeteorName()
            annotation.coordinate = location.coordinate
            meteorMapView.addAnnotation(annotation)
        }
        

        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        meteorMapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func setUpNavigationBarItem() {
        let leftButton = UIBarButtonItem(image: UIImage(named: "goBackImage"), style: .plain, target: self, action: #selector(self.dismissVC))
        self.navigationItem.leftBarButtonItem  = leftButton
        leftButton.tintColor = .white
    }
    
    func setUpFavourites() {
        guard let vModel = self.viewModel else { return }
        let tintColor = FavouritesManager.shared.isFavourite(meteor: vModel.getMeteor()) ? UIColor.green : .white,
            imageName = FavouritesManager.shared.isFavourite(meteor: vModel.getMeteor()) ? "isFavouriteImage" : "isNotFavouriteImage"

        let rightButton = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(self.onFavouriteClicked))
        self.navigationItem.rightBarButtonItem  = rightButton
        rightButton.tintColor = tintColor
    }

    @objc func onFavouriteClicked() {
        guard let vModel = self.viewModel else { return }
        FavouritesManager.shared.toggleFavourites(meteor: vModel.getMeteor())
        self.setUpFavourites()
    }
    
    @objc func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
