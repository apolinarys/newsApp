//
//  ViewController.swift
//  news
//
//  Created by Macbook on 14.09.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsManagerDelegate {
    func updateUI(newsModel: NewsModel, indexPath: IndexPath, cell: NewsTableViewCell) {
        cell.set(newsModel: newsModel)
    }
    
    
    let cellId = "NewsTableViewCellIdentifier"
    
    var newsManager = NewsManager()
    var newsModel: NewsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellIdentifier", for: indexPath) as! NewsTableViewCell
        newsManager.delegate = self
        newsManager.getData(indexPath: indexPath, cell: cell)
        
        return cell
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCellIdentifier")
        return tableView
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

