//
//  StateSelectTableViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/22/20.
//

import UIKit



class StateSelectTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var segueCompletion: ((String) -> Void)?
    var covidManager = CovidManager()
    var stateDictionary = StateTitle()
    var searchedResult = [String]()
    var searching = false
    @IBOutlet weak var stateSelectTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    //MARK: TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedState: String
        if searching {
            selectedState = stateDictionary.stateDictionary[searchedResult[indexPath.row]]!
        } else {
            selectedState = stateDictionary.stateDictionary[K.states[indexPath.row]]!
        }
        self.dismiss(animated: false, completion: {
            self.segueCompletion?(selectedState)
        })
        //        covidManager.fetchStatesCovidData(stateInitial: selectedState)
        //        dismiss(animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedResult.count
        } else {
            return K.states.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.statesCellIdentifier, for: indexPath)
        
        if searching {
            cell.textLabel?.text = searchedResult[indexPath.row]
        } else {
            cell.textLabel?.text = K.states[indexPath.row]
        }
        
        return cell
    }
    
    
}

extension StateSelectTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == false {
//            searchedResult = K.states.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased() })
            searchedResult = K.states.filter({$0.lowercased().contains(searchBar.text!.lowercased()) })
            searching = true
            tableView.reloadData()
        } else {
            searching = false
            searchBar.text = ""
            tableView.reloadData()
        }
        
    }
}
