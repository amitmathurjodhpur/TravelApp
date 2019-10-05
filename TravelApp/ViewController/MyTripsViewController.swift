//
//  MyTripsViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 26/03/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class MyTripsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var currentSelectedBtnColor:UIColor!
    var unselectedColor:UIColor!
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    var imageArray = [#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    var mainArray = [#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    var index : Int = 0
    @IBOutlet weak var cancelledTripsBtn: UIButton!
    @IBOutlet weak var completedTripsBtn: UIButton!
    @IBOutlet weak var upcomingTripsBtn: UIButton!
    @IBOutlet weak var allTripBtn: UIButton!
    
    @IBOutlet weak var tripTabel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        appDelegate.isTabBarBtnPress=true
        currentSelectedBtnColor=upcomingTripsBtn.titleLabel?.textColor
        unselectedColor=allTripBtn.titleLabel?.textColor
        tripTabel.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        ActivityIndicator.shared.show(self.view)

        imageArray.remove(at: index)
        tripTabel.reloadData()
        ActivityIndicator.shared.hide()

    }
    
    @IBAction func tripOptionBtnTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        switch button.tag {
        case 11:
            ActivityIndicator.shared.show(self.view)

            allTripBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            upcomingTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            completedTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            allTripBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            upcomingTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            completedTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            if imageArray.count > 0 {
                imageArray.removeAll()
            }
            for item in mainArray {
                imageArray.append(item)
            }
            
            tripTabel.reloadData()
            ActivityIndicator.shared.hide()

        case 12:
            ActivityIndicator.shared.show(self.view)

            allTripBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            upcomingTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            completedTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            allTripBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            upcomingTripsBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            completedTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            if imageArray.count > 0 {
                imageArray.removeAll()
            }
            for item in mainArray {
                imageArray.append(item)
            }
            tripTabel.reloadData()
            ActivityIndicator.shared.hide()

        case 13:
            ActivityIndicator.shared.show(self.view)

            allTripBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            upcomingTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            completedTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            cancelledTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            allTripBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            upcomingTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            completedTripsBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            cancelledTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            if imageArray.count > 0 {
                imageArray.removeAll()
            }
            for item in mainArray {
                imageArray.append(item)
            }
            tripTabel.reloadData()
            ActivityIndicator.shared.hide()

        case 14:
            ActivityIndicator.shared.show(self.view)

            allTripBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            upcomingTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            completedTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            allTripBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            upcomingTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            completedTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledTripsBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            if imageArray.count > 0 {
                imageArray.removeAll()
            }
            for item in mainArray {
                imageArray.append(item)
            }
            tripTabel.reloadData()
            ActivityIndicator.shared.hide()

        default:
            allTripBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            upcomingTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 14.0)
            completedTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            cancelledTripsBtn.titleLabel?.font=UIFont(name: "Montserrat-SemiBold", size: 10.0)
            allTripBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            upcomingTripsBtn.setTitleColor(currentSelectedBtnColor, for: UIControl.State.normal)
            completedTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
            cancelledTripsBtn.setTitleColor(unselectedColor, for: UIControl.State.normal)
        }
    }
    // MARK:- UITableView Delegate & Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.upcomingPackageName.text="HA LONG BAY"
        cell.upcomingTripDate.text="Mon 4th MAR 2019"
        cell.upcomingTotalAmount.text="$ 2500"
        cell.upcomingPackageTripImage.image = imageArray[indexPath.row]
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        /// change size as you need.
        separatorLineView.backgroundColor = self.view.backgroundColor
        // you can also put image here
        cell.contentView.addSubview(separatorLineView)
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex && thereIsCellTapped {
            return 300
        }
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
       self.tableView(tableView, cellForRowAt: indexPath).backgroundColor = UIColor.groupTableViewBackground
        if selectedRowIndex == indexPath.row {
            selectedRowIndex = -1
            self.thereIsCellTapped = false
        } else {
            selectedRowIndex = indexPath.row
            self.thereIsCellTapped = true
        }
       
        UIView.performWithoutAnimation {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
