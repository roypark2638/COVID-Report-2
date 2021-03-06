//
//  CovidManager.swift
//  COVID Report
//
//  Created by Roy Park on 11/19/20.
//

import Foundation

protocol CovidManagerDelegate {
    func didUpdateCovid(_ covidManager: CovidManager,_ covid: [CovidModel])
    func didFailWithError(_ error: Error)
}

struct CovidManager {
    let usCovidURL = "https://api.covidtracking.com/v1"
    let stateAbbreviations = [
    "States","AL","AK","AS","AZ","AR","CA","CO","CT","DE","DC","FM",
    "FL","GA","GU","HI","ID","IL","IN","IA","KS","KY","LA","ME","MH",
    "MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY",
    "NC","ND","MP","OH","OK","OR","PW","PA","PR","RI","SC","SD","TN",
    "TX","UT","VT","VI","VA","WA","WV","WI","WY"
    ]
    
    var delegate: CovidManagerDelegate?
    
    func fetchUSCovidData() {
        let urlString = "\(usCovidURL)/us/daily.json";
        performRequest(with: urlString)
    }
    
    func fetchStatesCovidData(stateInitial: String) {
        let urlString = "\(usCovidURL)/states/\(stateInitial)/us/daily.json";
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, reseponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if data != nil {
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                        
                        guard let covidData = json as? [Dictionary<String, Any>] else {return}
                        
//                        for data: Dictionary<String, Any> in covidData{
//                            if let infected = data["positive"] as? Dictionary<String, Any>{
//                                //here the data in address: { .. } is available
//                                //for example
//                                print(infected["positive"] ?? "")
//                            }
//                        }
                        var covidModel = [CovidModel]()
                        for x in stride(from: covidData.count - 1, through: 0, by: -1) {
                            let infectedNumber = covidData[x]["positive"] as! Int
                            let deathNumber = covidData[x]["death"] as? Int ?? 0
                            let VentilatorNumber = covidData[x]["onVentilatorCurrently"] as? Int ?? 0
                            let recoveredNumber = covidData[x]["recovered"] as? Int ?? 0
                            let updateTime = covidData[x]["lastModified"] as! String
                            let today = covidData[x]["date"] as! Int
                            
                            covidModel.append(CovidModel(positive: infectedNumber, death: deathNumber, onVentilatorCurrently: VentilatorNumber, recovered: recoveredNumber, lastModified: updateTime, date: today))
                        }
//                        let numberOfPositiveCase = covidData[0]["positive"] as! Int
//                        let numberOfDeathCase = covidData[0]["death"] as! Int
                        
//                        let covidModel = CovidModel(positive: numberOfPositiveCase , death: numberOfDeathCase)
//                        print(covidModel)
                        
                        self.delegate?.didUpdateCovid(self, covidModel)
//                        let covidVC = HomeViewController()
//                        covidVC.didUpdateCovid(covid: covidModel)
                        
                    }
                    catch{
                        delegate?.didFailWithError(error)
                        
                    }
                }
            }
            task.resume()
        }
    }
}
