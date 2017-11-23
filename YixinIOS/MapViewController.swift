//
//  MapViewController.swift
//  YixinIOS
//
//  Created by zeng tim on 24/8/2017.
//  Copyright © 2017年 zeng tim. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate, UISearchBarDelegate,AMapLocationManagerDelegate  {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBAction func search1(_ sender: Any) {//医院
        searchPOI(withKeyword: "医院")
    }
    @IBAction func search2(_ sender: Any) {//诊所
        searchPOI(withKeyword: "诊所")
    }
    @IBAction func search3(_ sender: Any) {//药房
        searchPOI(withKeyword: "药房")
    }
    var searchBar: UISearchBar!
    var search: AMapSearchAPI!
    var mapView: MAMapView!
    lazy var locationManager = AMapLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        initMapView()
        initSearch()
        initSearchBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initMapView() {
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.showsUserLocation = true;
        mapView.userTrackingMode = MAUserTrackingMode.follow;
        
        self.view.addSubview(mapView)
        self.view.addSubview(stackView)
    }
    
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    func initSearchBar() {
        searchBar = UISearchBar()
        searchBar.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        searchBar.delegate = self
        searchBar.placeholder = "请输入关键字"
        searchBar.sizeToFit()
//        self.navigationItem.titleView = searchBar
        self.navigationItem.title = "附近搜索"
    }
    
    
    //MARK: - Action
    
    func searchPOI(withKeyword keyword: String?) {
        
        if keyword == nil || keyword! == "" {
            return
        }
        
        //        let request = AMapPOIKeywordsSearchRequest()
        //        request.keywords = keyword
        //        request.requireExtension = true
        //        request.city = "上海"
        //
        //        search.aMapPOIKeywordsSearch(request)
        
        //        print("Location: \(mapView.userLocation.coordinate.longitude)")
        //        print("Location: \(mapView.userLocation.coordinate.latitude)")
        //        print("Location Keyword: \(keyword)")
        
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(mapView.userLocation.coordinate.latitude), longitude: CGFloat(mapView.userLocation.coordinate.longitude))
        request.keywords = keyword
        request.requireExtension = true
        search.aMapPOIAroundSearch(request)
    }
    
    //MARK:- UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchPOI(withKeyword: searchBar.text)
    }
    
    //MARK: - MAMapViewDelegate
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        //        print("updating: \(userLocation.coordinate.latitude)")
        //        print("updating: \(userLocation.coordinate.longitude)")
        
    }
    
    func mapView(_ mapView: MAMapView!, annotationView view: MAAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        print("name: \(String(describing: view.annotation.title))")
    }
    
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            
            annotationView!.canShowCallout = true
            annotationView!.isDraggable = false
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
            
            return annotationView!
        }
        
        return nil
    }
    
    
    
    //MARK: - AMapSearchDelegate
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        //        let nsErr:NSError? = error as NSError
        //        NSLog("Error:\(error) - \(ErrorInfoUtility.errorDescription(withCode: (nsErr?.code)!))")
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        if response.count == 0 {
            return
        }
        
        var annos = Array<MAPointAnnotation>()
        
        for aPOI in response.pois {
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(aPOI.location.latitude), longitude: CLLocationDegrees(aPOI.location.longitude))
            let anno = MAPointAnnotation()
            anno.coordinate = coordinate
            anno.title = aPOI.name
            anno.subtitle = aPOI.address
            annos.append(anno)
        }
        
        mapView.addAnnotations(annos)
        mapView.showAnnotations(annos, animated: false)
        mapView.selectAnnotation(annos.first, animated: true)
    }
    
}
