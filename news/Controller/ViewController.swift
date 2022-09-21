//
//  ViewController.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit
import WebKit

protocol DisplayNews: AnyObject {
    func displayData(newsModel: NewsModel)
}

class ViewController: UIViewController, DisplayNews {
    
    
    
    let cellId = "NewsTableViewCellIdentifier"
    
    var cellViewModel = CellViewModel()
    private var newsModel = NewsModel(cells: [])
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(Any?.self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh() {
        print("refresh")
        cellViewModel.presentData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        cellViewModel.viewController = self
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
        
        view.backgroundColor = .systemMint
        
        cellViewModel.presentData()
    }
    
    func displayData(newsModel: NewsModel) {
        print("Display data")
        self.newsModel = newsModel
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsModel.cells.count)
        return newsModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId, for: indexPath) as! NewsTableViewCell
        cell.backgroundColor = .clear
        let cellModel = newsModel.cells[indexPath.row]
        cell.set(newsModel: cellModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondVC: WebViewController = WebViewController()
        
        if let urlString = newsModel.cells[indexPath.row].url {
            if let url = URL(string: urlString) {
                secondVC.url = url
                self.present(secondVC, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        <#code#>
    }
}
