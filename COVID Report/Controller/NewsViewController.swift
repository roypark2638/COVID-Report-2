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
    
    // UIKit Variables
    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsManager.delegate = self
        tableView.register(UINib(nibName: "NewsArticleCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = self
        tableView.delegate = self
        
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
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewsArticleCell
        // currently display the correct images but beacuse of the different rendering time
        // there is a problem of showing a wrong image when you scroll fast.
        // possible fix is to use third party image downloader.
        cell.newsArticleImage.image = nil // set defaults image to nil in order not to use reusable cell displaying again.
        
        DispatchQueue.main.async {
            
            if let mainImageString = self.articles[indexPath.row].urlToImage {
                cell.newsArticleImage.imageFromURL(urlString: mainImageString)
            }
            
            cell.newsHeadingLabel.text = self.articles[indexPath.row].newsTitle
            cell.newsSubLabel.text = self.articles[indexPath.row].safeDescription
            cell.newsTimeLabel.text = self.articles[indexPath.row].publishedAt
            
        }
        return cell
    }
}

//MARK:: TableViewDelegate Methods
extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let articleURL = article.url else {
            print("error, loading the article.")
            return
        }
        
        let safariView = SFSafariViewController(url: articleURL)
        present(safariView, animated: true, completion: nil)
        
    }
}




