//
//  NewsManager.swift
//  COVID Report
//
//  Created by Roy Park on 12/9/20.
//

import Foundation
//https://newsapi.org/v2/everything?q=covid&language=en&source=us&apiKey=32ef00a987a4451ead6105a6e67e07a6

protocol NewsManagerDelegate {
    func didUpdateNews(_ newsManager: NewsManager,_ newsResults: [NewsModel])
    func didFail(with error: Error)
}
struct NewsManager {
    private let newsURL = "https://newsapi.org/v2/everything?q=covid&language=en&source=us&apiKey="
    private let newsApiKey = "32ef00a987a4451ead6105a6e67e07a6"
    var delegate: NewsManagerDelegate?
    func fetchNewsData() {
        let urlString = "\(newsURL)\(newsApiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFail(with: error!)
                    return
                }
                
                if let safeData = data {
                    if let news = self.parseJSON(safeData) {
                        self.delegate?.didUpdateNews(self, news)
                    }
                }
            }
            task.resume()
            
        }
    }
    // i need to have a collection of Article instance
    func parseJSON(_ newsData: Data) -> [NewsModel]? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsResult.self, from: newsData)
            var newsModel = [NewsModel]()
            for x in stride(from: decodedData.articles.count - 1, to: 0, by: -1) {
                
                let sourceName = decodedData.articles[x].source?.name ?? ""
                let title = decodedData.articles[x].title ?? ""
                let description = decodedData.articles[x].description ?? ""
                let content = decodedData.articles[x].content ?? ""
                let url = decodedData.articles[x].url
                let urlToImage = decodedData.articles[x].urlToImage ?? ""
                let publishedAt = decodedData.articles[x].publishedAt 
                
                let article = NewsModel(sourceName: sourceName, newsTitle: title, description: description, content: content, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
                
                newsModel.append(article)
                
            }
            return newsModel
            
        } catch {
            delegate?.didFail(with: error)
            return nil
        }
    }
}
