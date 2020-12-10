//
//  NewsViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/16/20.
//

import UIKit

class NewsViewController: UIViewController  {
    var newsManager = NewsManager()
    var articles = [NewsModel]()
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        newsManager.fetchNewsData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.newsNibName, bundle: nil), forCellReuseIdentifier: K.newsCellIdentifier)
        
        
    }
    

}
//MARK: NewsViewController Delegate Methods
extension NewsViewController: NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager,_ newsResults: [NewsModel]) {
        for article in newsResults {
            self.articles.append(article)
        }
    }
    func didFail(with error: Error) {
        print("Error reading data. \(error)")
    }
}

//MARK: NewViewController DataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(articles)
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = articles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.newsCellIdentifier, for: indexPath) as! NewsArticleCell
        cell.newsHeadingLabel.text = articles[indexPath.row].newsTitle
        
        
        return cell
    }
    
    
}
extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

    
    

