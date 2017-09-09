//
//  ViewController.swift
//  NestedTableViewPractice
//
//  Created by appinventiv on 07/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlet of tableView------
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    //Variables --------
     var expandedSections : NSMutableSet = []
    var countryArray: [String] = ["India"]
    var stateArray: [String] = ["UP", "Punjab"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeader = UINib(nibName: "HeaderOfCell", bundle: nil)
        tableViewOutlet.register(nibHeader, forHeaderFooterViewReuseIdentifier: "HeaderOfCellId")
        let nibCell = UINib(nibName: "ExpandingCell", bundle: nil)
        tableViewOutlet.register(nibCell, forCellReuseIdentifier: "ExpandingCellId")
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
       
    }

    
    @objc func headerBtnTap (sender: UIButton) {
        
       // print("Btn tap")
      //  print("Section tapped")
        let sec = sender.tag
      //  print(sec)
        let shouldExpand = !expandedSections.contains(sec)
        print(expandedSections)
        if (shouldExpand) {
           // expandedSections.remove(sec)
            //print(expandedSections)
            print("if me remove hone s pehle \(expandedSections)")
            expandedSections.add(sec)
            print("if me add hone k baad pehle \(expandedSections)")
            
        } else  {
            print("else me remove hone s pehle \(expandedSections)")
            expandedSections.remove(sec)
           print("else me remove hone k baad \(expandedSections)")
        }
        self.tableViewOutlet.reloadSections([sec], with: .bottom)
        
    }
    
    
}

// Extension of viewcontrolller-----

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
        return 1
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandingCellId", for: indexPath) as? ExpandingCell else {
            fatalError()  }
        
        cell.dataInSection = stateArray
       
       // cell.dataInCell = cityArray
        cell.contentView.backgroundColor = UIColor.brown
        return cell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderOfCellId") as! HeaderOfCell
        header.headerbtn.setTitle(countryArray[section], for: .normal)
        header.contentView.backgroundColor = UIColor.orange
        header.headerbtn.addTarget(self, action: #selector(ViewController.headerBtnTap(sender:)), for: UIControlEvents.touchUpInside)
         header.headerbtn.tag = section
        header.headerbtn.isUserInteractionEnabled = true
        if (expandedSections.contains(section)) {
            
            header.imageOutlet.image = UIImage(named: "down-arrow")
        }
        else {
            header.imageOutlet.image = UIImage(named: "right-arrow")
            
        }
        return header
    }
    
    
   
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
}

