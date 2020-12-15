//
//  StateSelectTableViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/22/20.
//

import UIKit



class StateSelectTableViewController: UITableViewController {
    
    var segueCompletion: ((String) -> Void)?    
    var covidManager = CovidManager()
    var stateDictionary = StateTitle()
    @IBOutlet weak var stateSelectTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
//MARK: TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedState = stateDictionary.stateDictionary[K.states[indexPath.row]]!
        self.dismiss(animated: false, completion: {
                        self.segueCompletion?(selectedState)
        })
//        covidManager.fetchStatesCovidData(stateInitial: selectedState)
//        dismiss(animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.statesCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = K.states[indexPath.row]
        return cell
    }
}
