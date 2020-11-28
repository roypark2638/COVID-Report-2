import TinyConstraints // for adding shadow and corner to image Add Pods
import UIKit
import Charts


class HomeViewController: UIViewController, ChartViewDelegate {
    
    var lineChart = LineChartView()
    var covidManager = CovidManager()
    
    @IBOutlet weak var TodayLabel: UILabel!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var totalInfectedLabel: UILabel!
    @IBOutlet weak var totalDeathLabel: UILabel!
    @IBOutlet weak var totalSevereCasesLabel: UILabel!
    @IBOutlet weak var totalRecoverLabel: UILabel!
    @IBOutlet weak var increasedInfectedLabel: UILabel!
    @IBOutlet weak var increasedDeathLabel: UILabel!
    @IBOutlet weak var increasedSevereCasesLabel: UILabel!
    @IBOutlet weak var increasedrecoveredLabel: UILabel!
    @IBOutlet weak var updateTime: UILabel!
    @IBOutlet weak var statesPicker: UIPickerView!
    
    
    @IBOutlet weak var areaSegment: UISegmentedControl! = {
        let v = UISegmentedControl()
        return v
    }()
    @IBOutlet weak var totalInfectedView: UIView!  = {
        let v = UIView()
        return v
    }()
    @IBOutlet weak var totalDeathView: UIView!  = {
        let v = UIView()
        return v
    }()
    
    @IBOutlet weak var dateInfectedView: UIView!  = {
        let v = UIView()
        return v
    }()
    
    @IBOutlet weak var dateDeathView: UIView!  = {
        let v = UIView()
        return v
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        covidManager.fetchUSCovidData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        covidManager.delegate = self
        statesPicker.delegate = self
        statesPicker.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setBackgroundToUIView()
        view.addSubview(lineChart)
        createLineChart()
        

    }
    
    func createLineChart() {
        // enable autolayout for our chart
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineChart.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 20).isActive = true
        lineChart.widthAnchor.constraint(equalToConstant: 385).isActive = true
        lineChart.heightAnchor.constraint(equalToConstant: 235).isActive = true
    }
    
    
    @IBAction func areaSegmentSelected(_ sender: UISegmentedControl) {
        
        // this is not working for some reason.
        if sender.titleForSegment(at: 0) == "United State" {
            lineChart.isHidden = false
            statesPicker.isHidden = true
        }
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems( [doneBtn], animated: true)
        lineChart.isHidden = true
        statesPicker.isHidden = false
    }
    
    
    
    
    
    
    
    func setBackgroundToUIView() {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "162 Perfect White")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        dateInfectedView.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        dateInfectedView.backgroundColor = UIColor.init(patternImage: image!)
        dateDeathView.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        dateDeathView.backgroundColor = UIColor.init(patternImage: image!)
        
        totalDeathView.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        totalInfectedView.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        totalDeathView.backgroundColor = UIColor.init(patternImage: image!)
        totalInfectedView.backgroundColor = UIColor.init(patternImage: image!)
        
        areaSegment.setCornerAndShadowToUIView(radius: 5, color: .darkGray, offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        areaSegment.selectedSegmentTintColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        areaSegment.backgroundColor = UIColor.init(patternImage: image!)
    }
    
}

//MARK: - CovidManagerDelegate
extension HomeViewController: CovidManagerDelegate {
        
    func didUpdateCovid(_ covidManager: CovidManager,_ covid: [CovidModel]) {
        DispatchQueue.main.async {
            let increasedCases = setIncreasedNumberOfCases()
            
            self.totalInfectedLabel.text = String(covid[0].positive)
            self.totalDeathLabel.text = String(covid[0].death!)
            self.totalSevereCasesLabel.text = String(covid[0].onVentilatorCurrently!)
            self.totalRecoverLabel.text = String(covid[0].recovered!)
            self.increasedInfectedLabel.text = String(increasedCases["positiveIncrease"]!)
            self.increasedDeathLabel.text = String(increasedCases["deathIncrease"]!)
            self.increasedSevereCasesLabel.text = String(increasedCases["severeCasesIncrease"]!)
            self.increasedrecoveredLabel.text = String(increasedCases["recoverIncrease"]!)
            self.TodayLabel.text = convertTodayFormat()
            
            var entries = [ChartDataEntry]()
            
            for x in 0..<covid.count {
                entries.append(ChartDataEntry(x: Double(x),
                                              y: Double(covid[x].positive)))
            }
            
            let set = LineChartDataSet(entries: entries)
            set.colors = ChartColorTemplates.material()
            let data = LineChartData(dataSet: set)
                self.lineChart.data = data
                
        }
        
        func setIncreasedNumberOfCases() -> [String:Int] {
            let positiveIncrease = covid[0].positive - covid[1].positive
            let deathIncrease = covid[0].death! - covid[1].death!
            let severeCasesIncrease = covid[0].onVentilatorCurrently! - covid[1].onVentilatorCurrently!
            let recoverIncrease = covid[0].recovered! - covid[1].recovered!
            let increasedCases = [ "positiveIncrease": positiveIncrease,
                                   "deathIncrease": deathIncrease,
                                   "severeCasesIncrease": severeCasesIncrease,
                                   "recoverIncrease": recoverIncrease,
            ]
            return increasedCases
        }
        
        func convertTodayFormat() -> String {
            let stringDate = String(covid[0].date)
            
            var start = stringDate.startIndex
            var end = stringDate.index(stringDate.endIndex, offsetBy: -4)
            let todayYear = stringDate[start..<end]
            start = end
            end = stringDate.index(stringDate.endIndex, offsetBy: -2)
            let todayMonth = stringDate[start..<end]
            start = end
            end = stringDate.index(stringDate.endIndex, offsetBy: -0)
            let todayDate = stringDate[start..<end]
            let today = String("\(todayYear)-\(todayMonth)-\(todayDate)")
            return today
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView

extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return covidManager.stateAbbreviations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return covidManager.stateAbbreviations[row]
    }
    
    
}

//MARK: - UIViewForCornerAndShadow

extension UIView {
    @discardableResult
    func setCornerAndShadowToUIView(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) -> UIView {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        
        
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        
        return self
    }
}

class SCButtonView: UIView {
    init(_ button: UIButton, radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float, cornerRadius: CGFloat) {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


