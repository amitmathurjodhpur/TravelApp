//
//  SearchViewController.swift
//  TravelApp
//
//  Created by Amit Mathur on 21/02/19.
//  Copyright © 2019 Amit Mathur. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchResultTabel: UITableView!
    var packageImageArray=[#imageLiteral(resourceName: "img7"),#imageLiteral(resourceName: "img3"),#imageLiteral(resourceName: "img5"),#imageLiteral(resourceName: "img1"),#imageLiteral(resourceName: "img2"),#imageLiteral(resourceName: "img4"),#imageLiteral(resourceName: "img6")]
    
    @IBAction func backButtonTapped(_ sender: Any) {
      //  self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func datepickerValueChanged(_ sender: Any) {
        let dateFormatter=DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat="dd-MM-yyyy"
        dateTextField.text=dateFormatter.string(from: (sender as AnyObject).date)
    }
    @IBAction func dateButtonTapped(_ sender: Any) {
        datePicker.isHidden=false
        searchLabel.isHidden=true
        searchResultTabel.isHidden=true
    }
    override func viewDidLoad() {
        searchLabel.isHidden=true
        searchResultTabel.isHidden=true
        datePicker.isHidden=true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        searchLabel.isHidden=false
        searchResultTabel.isHidden=false
         datePicker.isHidden=true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: UITableView Delegate & Data Source
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageImageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.packageImage.image=packageImageArray[indexPath.row]
        cell.packageNameLabel.text="Ha Long Bay"
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10))
        /// change size as you need.
        separatorLineView.backgroundColor = UIColor.groupTableViewBackground
        // you can also put image here
        cell.contentView.addSubview(separatorLineView)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
  
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
