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


    var monthOfDate: String {
        var firstNumberOfMonth = date / 1000
        var secondNumberOfMonth = date / 100
        firstNumberOfMonth = firstNumberOfMonth % 10
        secondNumberOfMonth = secondNumberOfMonth % 10
        return (String(firstNumberOfMonth) + String(secondNumberOfMonth))
    }
    
    var month:String {

        switch String(monthOfDate) {
        case "01":
            return "Jan"
        case "02":
            return "Feb"
        case "03":
            return "Mar"
        case "04":
            return "Apr"
        case "05":
            return "May"
        case "06":
            return "Jun"
        case "07":
            return "Jul"
        case "08":
            return "Aug"
        case "09":
            return "Sep"
        case "10":
            return "Oct"
        case "11":
            return "Nov"
        case "12":
            return "Dec"
        default:
            return ""
        }
    }
    
}

