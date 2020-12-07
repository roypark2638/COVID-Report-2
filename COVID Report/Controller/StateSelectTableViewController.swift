//
//  StateSelectTableViewController.swift
//  COVID Report
//
//  Created by Roy Park on 11/22/20.
//

import UIKit



class StateSelectTableViewController: UIViewController {
    
    var covidManager = CovidManager()
    var stateDictionary = StateTitle()
    @IBOutlet weak var stateSelectTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stateSelectTableView.delegate = self
        stateSelectTableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}


extension StateSelectTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(K.states[indexPath.row])
        
        let selectedState = stateDictionary.stateDictionary[K.states[indexPath.row]]!
        covidManager.fetchStatesCovidData(stateInitial: selectedState)
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension StateSelectTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = K.states[indexPath.row]
        return cell
    }
    
    
}
