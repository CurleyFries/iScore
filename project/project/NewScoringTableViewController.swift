//
//  NewScoringTableViewController.swift
//  project
//
//  Created by Chungchhay Kuoch on 12/1/18.
//  Copyright © 2018 Chungchhay Kuoch. All rights reserved.
//

import UIKit

class NewScoringTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataEnteredDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    let endData = ["END:   0", "END:   1", "END:   2", "END:   3", "END:   4"]
    var scoreData = ["Scores: 0", "Scores: 0", "Scores: 0", "Scores: 0", "Scores: 0",]
    var endTotalData = [0,0,0,0,0]
    var runTotalData = [0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Scoring Table"
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCellID")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return endData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID", for: indexPath) as! TableViewCell
        
        cell.commonInit(endData[indexPath.item], score: scoreData[indexPath.item], eTotal: "End Total:  " + String(endTotalData[indexPath.item]), rTotal: "Run Total:  " + String(runTotalData[indexPath.item]))
        
        cell.backgroundColor = UIColor(red: 255/255, green: 132/255, blue: 132/255, alpha: 1.0)
        cell.endLabel.textColor = .white
        cell.scoreLabel.textColor = .white
        cell.endTotal.textColor = .white
        cell.runTotal.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DvC = storyboard?.instantiateViewController(withIdentifier: "endsID") as! ENDSViewController
        
        DvC.getname = "Scores"
        DvC.end = indexPath.row
        DvC.delegate = self
        self.navigationController?.pushViewController(DvC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setEnd(argu: String, end: Int, scores: Array<Int>) {
        scoreData[end] = argu
        var endScore = 0
        for score in scores {
            endScore+=score
        }
        endTotalData[end] = endScore
        var runningTotal = 0
        var index = 0
        while index <= end {
            runningTotal += endTotalData[index]
            index+=1
        }
        
        runTotalData[end] = runningTotal
        
        
        tableView.reloadData()
    }
    

}
