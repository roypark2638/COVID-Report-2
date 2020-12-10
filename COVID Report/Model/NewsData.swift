//
//  NewsData.swift
//  COVID Report
//
//  Created by Roy Park on 12/9/20.
//

import Foundation

struct NewsResult: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var source: Source?
    var title: String
    var description: String?
    var content: String?
    var url: URL?
    var urlToImage: String?
    var publishedAt: String


}

struct Source: Codable {
    var name: String?
}
