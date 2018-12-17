//
//  NewsVC.swift
//  Pump Manage
//
//  Created by LaNet on 22/08/18.
//

import UIKit

class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblNews: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNews.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNews.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
