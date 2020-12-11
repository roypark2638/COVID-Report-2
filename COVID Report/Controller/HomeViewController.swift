import TinyConstraints // for adding shadow and corner to image Add Pods
import UIKit
import Charts


var months = [String]()

class HomeViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var todayLabel: UILabel!
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
    @IBOutlet weak var areaSegment: UISegmentedControl!
    @IBOutlet weak var totalInfectedView: UIView!
    @IBOutlet weak var totalDeathView: UIView!
    @IBOutlet weak var dateInfectedView: UIView!
    @IBOutlet weak var dateDeathView: UIView!
    
    var covidManager = CovidManager()
    var lineChart: LineChartView = {
        
        let chartView = LineChartView()
        chartView.leftAxis.enabled = false
        
        let yAxis = chartView.rightAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        
        yAxis.setLabelCount(7, force: false)
        yAxis.yOffset = 0
        yAxis.axisMinimum = 0
        
        chartView.xAxis.granularity = 30
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        chartView.xAxis.setLabelCount(10, force: false)
        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        covidManager.fetchUSCovidData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        covidManager.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setBackgroundToUIView()
        view.addSubview(lineChart)
        createLineChart()
    }
    
    
    @IBAction func areaSegmentSelected(_ sender: UISegmentedControl) {
        performSegue(withIdentifier: "goToStateList", sender: self)
    }
    
    
    func createLineChart() {
        let guide = self.view.safeAreaLayoutGuide
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 20).isActive = true
        lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        lineChart.trailingAnchor.constraint(equalTo: imageStackView.trailingAnchor, constant: 20).isActive = true
        lineChart.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0).isActive = true
    }
    
    
//MARK: SetBackGroundEffects
    func setBackgroundToUIView() {
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "Image-3")?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        dateInfectedView.setCornerAndShadowToUIView(radius: 5, color: .darkGray,
                                                    offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        dateDeathView.setCornerAndShadowToUIView(radius: 5, color: .darkGray,
                                                 offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        totalDeathView.setCornerAndShadowToUIView(radius: 5, color: .darkGray,
                                                  offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        totalInfectedView.setCornerAndShadowToUIView(radius: 5, color: .darkGray,
                                                     offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        areaSegment.setCornerAndShadowToUIView(radius: 5, color: .darkGray,
                                               offset: CGSize(width: 5, height: 5), opacity: 0.8, cornerRadius: 15)
        
        dateInfectedView.backgroundColor = UIColor.init(patternImage: image!)
        dateDeathView.backgroundColor = UIColor.init(patternImage: image!)
        totalDeathView.backgroundColor = UIColor.init(patternImage: image!)
        totalInfectedView.backgroundColor = UIColor.init(patternImage: image!)
        areaSegment.backgroundColor = UIColor.init(patternImage: image!)
                        
        totalInfectedLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        totalDeathLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        totalSevereCasesLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        totalRecoverLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        increasedInfectedLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        increasedDeathLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        increasedSevereCasesLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        increasedrecoveredLabel.textColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
        areaSegment.selectedSegmentTintColor = #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1)
    }
}

//MARK: - CovidManagerDelegate
extension HomeViewController: CovidManagerDelegate {
        
    func didUpdateCovid(_ covidManager: CovidManager,_ covid: [CovidModel]) {
        DispatchQueue.main.async { [self] in
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0

            let todayDataIndex = covid.count - 1
            let increasedCases = setIncreasedNumberOfCases(todayDataIndex)
            totalInfectedLabel.text = formatter.string(from: NSNumber(value: covid[todayDataIndex].positive))
            totalDeathLabel.text = formatter.string(from: NSNumber(value: covid[todayDataIndex].death!))
            totalSevereCasesLabel.text = formatter.string(from: NSNumber(value: covid[todayDataIndex].onVentilatorCurrently!))
            totalRecoverLabel.text = formatter.string(from: NSNumber(value: covid[todayDataIndex].recovered!))
            increasedInfectedLabel.text = formatter.string(from: NSNumber(value: increasedCases["positiveIncrease"]!))
            increasedDeathLabel.text = formatter.string(from: NSNumber(value: increasedCases["deathIncrease"]!))
            increasedSevereCasesLabel.text = formatter.string(from: NSNumber(value: increasedCases["severeCasesIncrease"]!))
            increasedrecoveredLabel.text = formatter.string(from: NSNumber(value: increasedCases["recoverIncrease"]!))
            todayLabel.text = convertTodayFormat(todayDataIndex)
            updateTime.text = covid[todayDataIndex].lastModified
            
            print(covid[todayDataIndex].month)
            
            var entries = [ChartDataEntry]()
            
            for x in 0..<covid.count {
                entries.append(ChartDataEntry(x: Double(x),
                                              y: Double(covid[x].positive)))
                months.append(covid[x].month)
            }
            
            let set = LineChartDataSet(entries: entries, label: "Infected")
            set.mode = .horizontalBezier
            set.lineWidth = 3
            set.setColor(.init(cgColor: #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)))
//            set.colors = ChartColorTemplates.joyful()
            set.drawCirclesEnabled = false
            set.fill = Fill.init(CGColor: #colorLiteral(red: 0.5330498219, green: 0.5818729401, blue: 0.9967882037, alpha: 1))
            set.fillAlpha = 0.3
            set.drawFilledEnabled = true
            
            let data = LineChartData(dataSet: set)
            data.setDrawValues(false)
                lineChart.data = data
            
            let valFormatter = NumberFormatter()
            valFormatter.numberStyle = .decimal
            valFormatter.maximumFractionDigits = 0
            self.lineChart.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
            self.lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        }
        
        func setIncreasedNumberOfCases(_ todayDataIndex:Int) -> [String:Int] {
            let positiveIncrease = covid[todayDataIndex].positive - covid[todayDataIndex - 1].positive
            let deathIncrease = covid[todayDataIndex].death! - covid[todayDataIndex - 1].death!
            let severeCasesIncrease = covid[todayDataIndex].onVentilatorCurrently! - covid[todayDataIndex - 1].onVentilatorCurrently!
            let recoverIncrease = covid[todayDataIndex].recovered! - covid[todayDataIndex - 1].recovered!
            let increasedCases = [ "positiveIncrease": abs(positiveIncrease),
                                   "deathIncrease": abs(deathIncrease),
                                   "severeCasesIncrease": abs(severeCasesIncrease),
                                   "recoverIncrease": abs(recoverIncrease)
            ]
            return increasedCases
        }
        
        //20201122
        func convertTodayFormat(_ todayDataIndex: Int) -> String {
            let stringDate = String(covid[todayDataIndex].date)
            
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


