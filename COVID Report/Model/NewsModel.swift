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
    let publishedAt: String?
    
    var publishedConvertedToDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: publishedAt ?? "") ?? nil
    }
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
    
    var passedTimeSinceDate: String {
        if let fromDate = publishedConvertedToDate {
        let toDate = Date()
        
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0 {
            return interval == 1 ? "\(interval)" + " year ago" : "\(interval)" + " years ago"
        }
        
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0 {
            return interval == 1 ? "\(interval)" + " month ago" : "\(interval)" + " months ago"
        }
        
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0 {
            return interval == 1 ? "\(interval)" + " day ago" : "\(interval)" + " days ago"
        }
        
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            return interval == 1 ? "\(interval)" + " hour ago" : "\(interval)" + " hours ago"
        }
        
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            return interval == 1 ? "\(interval)" + " minute ago" : "\(interval)" + " minutes ago"
        }
        
        if let interval = Calendar.current.dateComponents([.second], from: fromDate, to: toDate).second, interval > 0 {
            return interval == 1 ? "\(interval)" + " second ago" : "\(interval)" + " seconds ago"
        }
            return "just posted"
        }
        return "Unknown time"
    }
    
}
