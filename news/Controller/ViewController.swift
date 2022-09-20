//
//  ViewController.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit

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
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        cellViewModel.viewController = self
        self.view.addSubview(tableView)
        view.backgroundColor = .blue
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        cellViewModel.presentData()
    }
    
    func displayData(newsModel: NewsModel) {
        print("Display data")
        self.newsModel = newsModel
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsModel.cells.count)
        return newsModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId, for: indexPath) as! NewsTableViewCell
        let cellModel = newsModel.cells[indexPath.row]
        cell.set(newsModel: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = newsModel.cells[indexPath.row]
        return cellModel.sizes.totalHeight
    }
    
}
