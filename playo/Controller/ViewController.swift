//
//  ViewController.swift
//  playo
//
//  Created by manukant tyagi on 18/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    var data: [Article] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()
    //MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewRequiredStuff()
        self.view.activityStartAnimating()
        getData()
    }
    
    //MARK: - functions
    func tableViewRequiredStuff(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    // get data through api call
    func getData(){
        getApiCall { model in
            if let model = model {
                DispatchQueue.main.sync {
                    self.data = model.articles
                    self.view.activityStopAnimating()
                }
            }
        }
    }

    // call on pull to refresh
    @objc func refresh(){
        refreshControl.beginRefreshing()
        getApiCall { model in
            if let model = model {
                DispatchQueue.main.sync {
                    self.refreshControl.endRefreshing()
                    self.data = model.articles
                    self.view.activityStopAnimating()
                }
            }
        }
    }

}

//MARK: - table view datasources and delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsTableViewCell
        cell.urlString = data[indexPath.row].urlToImage ?? ""
        cell.titleLabel.text = data[indexPath.row].title ?? ""
        cell.descriptionLabel.text = data[indexPath.row].description ?? ""
        cell.authorLabel.text = "Author - \(data[indexPath.row].author ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        tableView.deselectRow(at: indexPath, animated: true)
        vc.urlString = data[indexPath.row].url ?? ""
        self.present(vc, animated: true)
    }
    
    
}

