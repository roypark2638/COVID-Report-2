//
//  NewsViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/16/20.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController  {
    
    // Data variables
    var newsManager = NewsManager()
    var articles = [NewsModel]()
    private var imageCache: [String: UIImage] = [:]
//    private var downloader = ImageDownloader()
    
    // UIKit Variables
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        tableView.register(UINib(nibName: "NewsArticleCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        
//        if let tv = tableView {
//            view.addSubview(tv)
//        }
        
        newsManager.fetchNewsData()
    }
    
}
//MARK: NewsViewController Delegate Methods
extension NewsViewController: NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager,_ newsResults: [NewsModel]) {
        for article in newsResults {
            self.articles.append(article)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func didFail(with error: Error) {
        print("Error reading news data in NewsViewController Delegate Methods. \(error)")
    }
}

//MARK: NewViewController DataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(articles)
        DispatchQueue.main.async {
            print("Print the number of articles: \(self.articles.count)")
            self.articles.count
        }
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let article = self.articles[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewsArticleCell
    //        let identifier = article.identifier
        DispatchQueue.main.async {
            cell.newsHeadingLabel.text = self.articles[indexPath.row].newsTitle
            cell.newsSubLabel.text = self.articles[indexPath.row].safeDescription
            cell.newsTimeLabel.text = self.articles[indexPath.row].passedTimeSinceDate
            
                
            
        }
        return cell
    }
    
    
}
extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

    
    

