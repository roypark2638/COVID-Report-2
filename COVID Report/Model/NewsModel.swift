//
//  NewsModel.swift
//  COVID Report
//
//  Created by Roy Park on 12/9/20.
//

import Foundation

struct NewsModel {
    let sourceName: String
    let newsTitle: String
    let description: String?
    let content: String?
    let url: URL?
    let urlToImage: String?
    let publishedAt: String
    
    var safeDescription: String {
        return description ?? content!
    }
    
    var identifier: String? {
        return url?.absoluteString ?? urlToImage
    }
    
    var sourceLogo: String {
        guard let host = url?.host else { return "" }
        return "https://logo.clearbit.com/\(host)"
    }
    
    var urlToGreySourceLogo: String {
        guard let host = url?.host else { return "" }
        return "https://logo.clearbit.com/\(host)?greyscale=true"
    }
}
