//
//  ViewController.swift
//  CryptocurrencyApp
//
//  Created by Mac on 4/18/18.
//  Copyright © 2018 Green Moby. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        return refreshControl
    }()
    
    var modelArray = [CoinEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.addSubview(refreshControl)
        loadData()
    }
    
    func loadData() {
        let apiManager = ApiManager()
        apiManager.getCrypto(complite: {(coinEntites) in
            self.modelArray = coinEntites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! Cell
        cell.coinKeyLabel?.text = modelArray[indexPath.row].coinKey
        cell.coinTitleLabel?.text = "| " + modelArray[indexPath.row].coinTitle
        cell.coinPriceLabel?.text = modelArray[indexPath.row].coinPrice + "$"
        cell.coin24hСhangeLabel?.text = modelArray[indexPath.row].coin24hСhange + "%"
        if Double(modelArray[indexPath.row].coin24hСhange)! < 0 {
            cell.coin24hСhangeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            cell.coin24hСhangeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        cell.coin7dСhangeLabel?.text = modelArray[indexPath.row].coin7dСhange + "%"
        if Double(modelArray[indexPath.row].coin7dСhange)! < 0 {
            cell.coin7dСhangeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            cell.coin7dСhangeLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        if let url = URL(string: ApiManager.urlIcons + modelArray[indexPath.row].urlCoinIcon){
            cell.coinImageView.kf.setImage(with: url)
        }
        return cell
    }
}

