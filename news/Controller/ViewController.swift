//
//  ViewController.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit
import WebKit
import CoreData

protocol DisplayNews: AnyObject {
    func displayData(newsModel: NewsModel)
}

class ViewController: UIViewController, DisplayNews {
    
    var newsNumber = 20
    
    let cellId = "NewsTableViewCellIdentifier"
    
    var cellViewModel = CellViewModel()
    var newsModel = NewsModel(cells: [])
    let dataManager = DataManager()
    
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
        
        newsModel.cells = dataManager.loadingData() ?? []
         
        if newsModel.cells.count != 0{
            tableView.reloadData()
        }
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
        SceneDelegate.newsItems = newsModel.cells
        refreshControl.endRefreshing()
    }


}

//MARK: - Extension

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsModel.cells.count)
        if newsModel.cells.count > newsNumber {
            return newsNumber
        } else {
            return newsModel.cells.count
        }
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
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            newsNumber += 20
            print("more data")
            tableView.reloadData()
        }
    }
}
