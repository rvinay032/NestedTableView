//
//  ExpandingCell.swift
//  NestedTableViewPractice
//
//  Created by appinventiv on 07/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit

class ExpandingCell: UITableViewCell {
    var expandedSections : NSMutableSet = []
    var dataInSection = [""]
    var dataInCell = [""]
    var cityArray = ["Saharanpur", "Agra", "Meerut"]
    var cityArray2 = ["Chandigarh", "ludhiana", "Jalandhar"]
    
    @IBOutlet weak var nestedTableVIewOutlet: UITableView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nibCellOnCell = UINib(nibName: "CellOnCell", bundle: nil)
        nestedTableVIewOutlet.register(nibCellOnCell, forCellReuseIdentifier: "CellOnCellId")
        let nibheaderOnCell = UINib(nibName: "HeaderOfCell", bundle: nil)
        nestedTableVIewOutlet.register(nibheaderOnCell, forHeaderFooterViewReuseIdentifier: "HeaderOfCellId")
        
        
        nestedTableVIewOutlet.delegate = self
        nestedTableVIewOutlet.dataSource = self
        
        
    }

    
    @objc func headerBtnTap (sender: UIButton) {
        
       // print("Btn tap")
        //print("Section tapped")
        let sec = sender.tag
       // print(sec)
        let shouldExpand = !expandedSections.contains(sec)
        print(expandedSections.contains(sec))
        print(shouldExpand)
        if (shouldExpand) {
            
            expandedSections.remove(sec)
            print("remove hone se pehle \(expandedSections)")
            print(sec)
            expandedSections.add(sec)
              print("add hone ke baad \(expandedSections)")
            //print(expandedSections)
            
        } else  {
              print("Else ke andar remove hone se pehle \(expandedSections)")
            expandedSections.remove(sec)
            //print(expandedSections)
        }
        self.nestedTableVIewOutlet.reloadSections([sec], with: .middle)
        
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ExpandingCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch(section) {
            case 0:
                return cityArray.count
            default:
                return cityArray2.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOnCellId", for: indexPath) as! CellOnCell
        switch indexPath.section {
        case 0:
          //  print("case 0")
            cell.nestedLabel.text = cityArray[indexPath.row]
            
        default:
           // print("1")
            cell.nestedLabel.text = cityArray2[indexPath.row]
            
        }
        cell.contentView.backgroundColor = UIColor.black
        //cell.nestedLabel.text = dataInCell[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderOfCellId") as? HeaderOfCell else{fatalError("Header not found")}
        header.headerbtn.setTitle(dataInSection[section], for: .normal)
        header.headerbtn.addTarget(self, action: #selector(ViewController.headerBtnTap(sender:)), for: UIControlEvents.touchUpInside)
        header.headerbtn.tag = section
        header.headerbtn.backgroundColor = UIColor.gray
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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataInSection.count
    }
    
}

