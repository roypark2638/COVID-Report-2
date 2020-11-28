//
//  CovideModel.swift
//  COVID Report
//
//  Created by Roy Park on 11/19/20.
//

import Foundation

struct CovidModel {
    let positive: Int
    let death: Int?
    let onVentilatorCurrently: Int?
    let recovered: Int?
    let lastModified: String
    let date: Int

    var month:String {
        let start = String(date).index(String(date).startIndex, offsetBy: 4)
        let end = String(date).index(String(date).endIndex, offsetBy: -2)
        let tempMonth = String(String(date)[start..<end])
        
        switch Int(tempMonth) {
        case 01:
            return "Jan"
        case 02:
            return "Feb"
        case 03:
            return "Mar"
        case 04:
            return "Apr"
        case 05:
            return "May"
        case 06:
            return "Jun"
        case 07:
            return "Jul"
        case 08:
            return "Aug"
        case 09:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
    
}
