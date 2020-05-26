//
//  ChartVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/02.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import Charts

class ChartVC: BaseVC {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var changeChartCategoryButton: UIButton!
    @IBOutlet weak var changeTermButton: UIButton!
    
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var dataTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addDataButton: UIButton!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    fileprivate lazy var dateFormatterForCell: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter
    }()
    
    var date: String = ""
    var weight: Double = 0
    
    var chartData: [ChartData] = []
    var chartCategoryName: String = "체중"
    /// - description: 1은 몸무게, 2는 체지방률
    var chartCategory: Int = 1
    /// - description: 1은 주간, 2는 월간, 3은 년간
    var chartDate: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.date = self.dateFormatter.string(from: Date())
        
        self.setChartView()
        self.changeChartCategoryButton.layer.borderColor = UIColor.blue.cgColor
        self.changeChartCategoryButton.layer.borderWidth = 1
        
        self.changeTermButton.layer.borderColor = UIColor.blue.cgColor
        self.changeTermButton.layer.borderWidth = 1
        
        self.dataTableView.delegate = self
        self.dataTableView.dataSource = self
        self.dataTableView.register(ChartCell.self, forCellReuseIdentifier: "ChartCell")
        
        self.changeTermButton.addTarget(self, action: #selector(self.pressSetDateButton), for: .touchUpInside)
        self.changeChartCategoryButton.addTarget(self, action: #selector(self.pressSetCategoryButton), for: .touchUpInside)
        
        self.addDataButton.addTarget(self, action: #selector(self.pressAddChartDataButton), for: .touchUpInside)
        
        let chartDataManager = ChartDataManager()
        chartDataManager.retrieveWeekData(fromVC: self)
    }
    
    private func setChartView() {
        self.lineChartView.delegate = self
        self.lineChartView.chartDescription?.enabled = false
        self.lineChartView.dragEnabled = true
        self.lineChartView.setScaleEnabled(true)
        self.lineChartView.pinchZoomEnabled = false
        
        let l = lineChartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.axisMinimum = 0
        
//        let xAxis = lineChartView.xAxis
//        xAxis.labelPosition = .bothSided
//        xAxis.axisMinimum = 0
//        xAxis.granularity = 1
//        xAxis.valueFormatter = self
        
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = lineChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        self.lineChartView.marker = marker
        
        self.updateChartData()
        
        self.lineChartView.legend.form = .line
    }
    
    private func updateDataTableViewHeight(value: CGFloat) {
        self.dataTableViewHeightConstraint.constant = value
    }
    
    @objc func pressSetDateButton() {
        self.chartData.removeAll()
        
        let chartDataManager = ChartDataManager()
        
        let dateFormatter = DateFormatter()
        let dateFormatterForReq = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월dd일"
        dateFormatterForReq.dateFormat = "yyyy-MM-dd"
    
        let alert: UIAlertController = UIAlertController(title: "기간 설정", message: nil, preferredStyle: .actionSheet)
        let weekAction = UIAlertAction(title: "주간", style: .default, handler: { _ in
            self.chartDate = 1
            chartDataManager.retrieveWeekData(fromVC: self)
        })
        let monthAction = UIAlertAction(title: "월간", style: .default, handler: { _ in
            self.chartDate = 2
            chartDataManager.retrieveMonthData(fromVC: self)
        })
        let yearAction = UIAlertAction(title: "연간", style: .default, handler: { _ in
            self.chartDate = 3
            chartDataManager.retrieveYearData(fromVC: self)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(weekAction)
        alert.addAction(monthAction)
        alert.addAction(yearAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSetCategoryButton() {
        let alert: UIAlertController = UIAlertController(title: "분석 종류 설정", message: nil, preferredStyle: .actionSheet)
        let weightAction = UIAlertAction(title: "체중", style: .default, handler: { _ in
            self.chartCategory = 1
            self.chartCategoryName = "체중"
        })
        
        let fatRateAction = UIAlertAction(title: "체지방률", style: .default, handler: { _ in
//            self.chartCategory = 2
//            self.chartCategoryName = "체지방률"
            
            self.presentAlert(title: "준비중", message: "기능 준비중입니다")
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(weightAction)
        alert.addAction(fatRateAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressAddChartDataButton() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { (make) in
            make.centerX.equalTo(alert.view)
            make.top.equalTo(alert.view).offset(8)
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.date = self.dateFormatter.string(from: datePicker.date)
            DispatchQueue.main.async {
                self.pressSettingWeightView()
            }
                        
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func pressSettingWeightView() {
        let alert = UIAlertController(title: "몸무게 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if alert.textFields![0].text != "" {
                self.weight = Double(alert.textFields![0].text!)!
            }
            
            let chartDataManager = ChartDataManager()
            chartDataManager.addChartData(fromVC: self, weight: self.weight, date: self.date)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
extension ChartVC: ChartViewDelegate {
    
    func updateChartData() {
        var chartDataEntrys: [ChartDataEntry] = []
        for data in self.chartData {
            chartDataEntrys.append(ChartDataEntry(x: data.xValue, y: data.yValue))
        }
        
        self.setDataCount(chartDataEntrys)
    }
    
    func setDataCount(_ dataSet: [ChartDataEntry]) {

        let set1 = LineChartDataSet(entries: dataSet, label: self.chartCategoryName)
        set1.drawIconsEnabled = false
        
        set1.lineDashLengths = [5, 2.5]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
                
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
    }
    
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        let data = self.chartData[Int(value) % chartData.count].date
//        print(data)
//        return self.chartData[Int(value) % chartData.count].date
//    }
}
extension ChartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.updateDataTableViewHeight(value: CGFloat(70 * self.chartData.count))
        return self.chartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as? ChartCell else {
            return UITableViewCell()
        }
        cell.weightLabel.text = "\(self.chartData[indexPath.row].yValue)"
        let date = self.dateFormatter.date(from: self.chartData[indexPath.row].date)!
        cell.dateLabel.text = self.dateFormatterForCell.string(from: date)
        
        return cell
    }
    
}
