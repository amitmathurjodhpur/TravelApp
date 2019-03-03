//
//  FirstViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 12/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit
import QuartzCore

class PackageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var destinationNameScrollView: UIScrollView!
    @IBOutlet weak var packageCollectionView: UICollectionView!
    var packageImageArray=[#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    
   
    
    @IBOutlet weak var destinationCollectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var destinationNames=["Ha Long Bay","Fansipan","Catba island","Ha Long Bay","Ha Long Bay","Ha Long Bay","Ha Long Bay"]
    var destinationImageArray=[#imageLiteral(resourceName: "dimg6"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "dimg5"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "dimg3"),#imageLiteral(resourceName: "img6"),#imageLiteral(resourceName: "dimg2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isScrollEnabled=true
        destinationNameScrollView.isScrollEnabled=true
    }
    @IBAction func searchTapped(_ sender: Any) {
        if let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            self.definesPresentationContext = true
            searchVC.modalPresentationStyle = .overCurrentContext
            self.present(searchVC, animated: true, completion: nil)

        }
        
    }
    override func viewDidLayoutSubviews() {
         scrollView.contentSize=CGSize(width: scrollView.frame.width, height: self.view.frame.height+500)
        destinationNameScrollView.contentSize=CGSize(width: destinationNameScrollView.frame.width+500, height: destinationNameScrollView.frame.height)
    }
    // Mark: UITableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageImageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.packageImage.image=packageImageArray[indexPath.row]
        cell.packageNameLabel.text="HA LONG BAY"
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        /// change size as you need.
        separatorLineView.backgroundColor = self.view.backgroundColor
        // you can also put image here
        cell.contentView.addSubview(separatorLineView)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
// Mark: UICollectionView Delegate & Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return packageImageArray.count
        } else {
            return destinationImageArray.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if collectionView.tag == 1 {
            cell.packageImageView.image=packageImageArray[indexPath.row]
        } else {
            cell.destinationImageView.image=destinationImageArray[indexPath.row]
           // cell.destinationNameLabel.text=destinationNames[indexPath.row]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1 {
            if let packageDetail = self.storyboard?.instantiateViewController(withIdentifier: "PackageDetailViewController") as? PackageDetailViewController {
                packageDetail.packageImage=packageImageArray[indexPath.row]
                self.definesPresentationContext = true
                packageDetail.modalPresentationStyle = .overCurrentContext
               // self.navigationController?.pushViewController(packageDetail, animated: true)
                self.present(packageDetail, animated: false, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

