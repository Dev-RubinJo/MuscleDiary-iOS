//
//  FoodVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/02.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit
import SafariServices
import Firebase

class FoodVC: BaseVC {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    @IBOutlet weak var calorieInfoView: UIView!
    @IBOutlet weak var targetCalorieLabel: UILabel!
    @IBOutlet weak var gainCalorieLabel: UILabel!
    @IBOutlet weak var remainCalorieLabel: UILabel!
    
    @IBOutlet weak var carbohydrateView: UIView!
    @IBOutlet weak var carbohydrateCircleProgressView: CircularProgressView!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var recommendCarbohydrateLabel: UILabel!
    
    @IBOutlet weak var proteinView: UIView!
    @IBOutlet weak var proteinCircleProgressView: CircularProgressView!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var recommendProteinLabel: UILabel!
    
    @IBOutlet weak var fatView: UIView!
    @IBOutlet weak var fatCircleProgressView: CircularProgressView!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var recommendFatLabel: UILabel!
    
    @IBOutlet weak var proteinAdvertiseView: UIView!
    @IBOutlet weak var proteinAdvertiseViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var proteinAdvertiseWebViewButton: UIButton!
    
    @IBOutlet weak var breakfastView: UIView!
    @IBOutlet weak var breakfastViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breakfastTotalCalorieLabel: UILabel!
    @IBOutlet weak var breakfastFoodAddButton: UIButton!
    @IBOutlet weak var breakfastFoodTableView: UITableView!
        
    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var lunchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lunchTotalCalorieLabel: UILabel!
    @IBOutlet weak var lunchFoodAddButton: UIButton!
    @IBOutlet weak var lunchFoodTableView: UITableView!
    
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var dinnerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dinnerTotalCalorieLabel: UILabel!
    @IBOutlet weak var dinnerFoodAddButton: UIButton!
    @IBOutlet weak var dinnerFoodTableView: UITableView!
    
    @IBOutlet weak var etcView: UIView!
    @IBOutlet weak var etcViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var etcTotalCalorieLabel: UILabel!
    @IBOutlet weak var etcFoodAddButton: UIButton!
    @IBOutlet weak var etcFoodTableView: UITableView!
    
    var carbohydrate: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    var totalCalorie: Double = 0
    
    var recommendCarbohydrate: Double = 120
    var recommendProtein: Double = 120
    var recommendFat: Double = 100
    
    var targetCalorie: Double = 0
    
    var breakfastFoodList: [Food] = []
    var lunchFoodList: [Food] = []
    var dinnerFoodList: [Food] = []
    var etcFoodList: [Food] = []
    
    var date: String = ""
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.date = self.dateFormatter.string(from: Date())
        self.calorieInfoView.layer.cornerRadius = 20
        self.initFsCalendar()
        
        Analytics.logEvent("FoodVC_iOS", parameters: ["req": "FoodVC_iOS"])
        
        let dataManager = FoodDataManager()
        dataManager.retrieveNutritionInfo(fromVC: self)
        dataManager.retrieveFoodList(fromVC: self, date: self.dateFormatter.string(from: Date()))
        
        
        self.proteinAdvertiseWebViewButton.addTarget(self, action: #selector(self.presentProteinWebView), for: .touchUpInside)
        
        self.setBreakfastView(heightValue: 0)
        self.setLunchView(heightValue: 0)
        self.setDinnerView(heightValue: 0)
        
        self.breakfastFoodTableView.delegate = self
        self.breakfastFoodTableView.dataSource = self
        self.breakfastFoodTableView.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
        
        self.lunchFoodTableView.delegate = self
        self.lunchFoodTableView.dataSource = self
        self.lunchFoodTableView.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
        
        self.dinnerFoodTableView.delegate = self
        self.dinnerFoodTableView.dataSource = self
        self.dinnerFoodTableView.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
        
        self.etcFoodTableView.delegate = self
        self.etcFoodTableView.dataSource = self
        self.etcFoodTableView.register(FoodCell.self, forCellReuseIdentifier: "FoodCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dataManager = FoodDataManager()
        dataManager.retrieveNutritionInfo(fromVC: self)
        dataManager.retrieveFoodList(fromVC: self, date: self.dateFormatter.string(from: Date()))
        self.updateCircleProgressBar()
        self.reloadTableView()
    }
    
    private func initFsCalendar() {
        self.fsCalendar.clipsToBounds = true
        self.fsCalendar.select(Date())
        
        self.fsCalendar.scope = .week
        self.fsCalendar.isUserInteractionEnabled = true
        
        self.fsCalendar.delegate = self
        self.fsCalendar.dataSource = self
    }
    
    func setCircleProgressView(time: TimeInterval) {
        self.carbohydrateCircleProgressView.progressAnimation(duration: time, value: self.carbohydrate / self.recommendCarbohydrate, color: .purple)
        self.carbohydrateLabel.text = "\(Int(self.carbohydrate))"
        self.recommendCarbohydrateLabel.text = "\(Int(self.recommendCarbohydrate))"
        
        self.proteinCircleProgressView.progressAnimation(duration: time, value: self.protein / self.recommendProtein, color: .green)
        self.proteinLabel.text = "\(Int(self.protein))"
        self.recommendProteinLabel.text = "\(Int(self.recommendProtein))"
        
        if self.protein >= self.recommendProtein {
            self.setAdView(isOn: false)
        } else {
            self.setAdView(isOn: true)
        }
        
        self.fatCircleProgressView.progressAnimation(duration: time, value: self.fat / self.recommendFat, color: .yellow)
        self.fatLabel.text = "\(Int(self.fat))"
        self.recommendFatLabel.text = "\(Int(self.recommendFat))"
    }
    
    private func setAdView(isOn: Bool) {
        if isOn {
            self.proteinAdvertiseViewHeightConstraint.constant = 100
            self.proteinAdvertiseView.isHidden = false
        } else {
            self.proteinAdvertiseViewHeightConstraint.constant = 0
            self.proteinAdvertiseView.isHidden = true
        }
    }
    
    func updateCircleProgressBar() {
        // 초기화
        self.totalCalorie = 0
        self.carbohydrate = 0
        self.protein = 0
        self.fat = 0
        
        var breakfastCalorie: Double = 0
        var lunchCalorie: Double = 0
        var dinnerCalorie: Double = 0
        var etcCalorie: Double = 0
        
        for breakfast in self.breakfastFoodList {
            self.totalCalorie += breakfast.calorie * breakfast.serving
            self.carbohydrate += breakfast.carbohydrate * breakfast.serving
            breakfastCalorie += breakfast.calorie * breakfast.serving
            self.protein += breakfast.protein * breakfast.serving
            self.fat += breakfast.fat * breakfast.serving
        }
        self.breakfastTotalCalorieLabel.text = "\(breakfastCalorie)"
        
        for lunch in self.lunchFoodList {
            self.totalCalorie += lunch.calorie * lunch.serving
            self.carbohydrate += lunch.carbohydrate * lunch.serving
            lunchCalorie += lunch.calorie * lunch.serving
            self.protein += lunch.protein * lunch.serving
            self.fat += lunch.fat * lunch.serving
        }
        self.lunchTotalCalorieLabel.text = "\(lunchCalorie)"
        
        for dinner in self.dinnerFoodList {
            self.totalCalorie += dinner.calorie * dinner.serving
            self.carbohydrate += dinner.carbohydrate * dinner.serving
            dinnerCalorie += dinner.calorie * dinner.serving
            self.protein += dinner.protein * dinner.serving
            self.fat += dinner.fat * dinner.serving
        }
        self.dinnerTotalCalorieLabel.text = "\(dinnerCalorie)"
        
        for etc in self.etcFoodList {
            self.totalCalorie += etc.calorie * etc.serving
            self.carbohydrate += etc.carbohydrate * etc.serving
            etcCalorie += etc.calorie * etc.serving
            self.protein += etc.protein * etc.serving
            self.fat += etc.fat * etc.serving
        }
        self.etcTotalCalorieLabel.text = "\(etcCalorie)"
        
        if self.targetCalorie != 0 && self.totalCalorie != 0 {
//            (round(self.breakfastFoodList[indexPath.row].calorie * 10) / 10) * self.breakfastFoodList[indexPath.row].serving
            self.gainCalorieLabel.text = "\(round(self.totalCalorie * 10) / 10)"
            self.remainCalorieLabel.text = "\(round((self.targetCalorie - self.totalCalorie) * 10) / 10)"
        } else {
            self.gainCalorieLabel.text = "섭취 칼로리"
            self.remainCalorieLabel.text = "잔여 칼로리"
        }
        
        self.setCircleProgressView(time: 0.5)
    }
    
    private func setBreakfastView(heightValue: CGFloat) {
        self.breakfastView.layer.cornerRadius = 5
        self.breakfastViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func setLunchView(heightValue: CGFloat) {
        self.lunchView.layer.cornerRadius = 5
        self.lunchViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func setDinnerView(heightValue: CGFloat) {
        self.dinnerView.layer.cornerRadius = 5
        self.dinnerViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func setEtcView(heightValue: CGFloat) {
        self.etcView.layer.cornerRadius = 5
        self.etcViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func reloadTableView() {
        self.breakfastFoodTableView.reloadData()
        self.lunchFoodTableView.reloadData()
        self.dinnerFoodTableView.reloadData()
        self.etcFoodTableView.reloadData()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddFoodVC else { return }
        vc.addFoodDelegate = self
//        vc.date =
        if segue.identifier == "breakfastSegue" {
            vc.navigationItem.title = "아침"
            vc.dishCategory = 0
        } else if segue.identifier == "lunchSegue" {
            vc.navigationItem.title = "점심"
            vc.dishCategory = 1
        } else if segue.identifier == "dinnerSegue" {
            vc.navigationItem.title = "저녁"
            vc.dishCategory = 2
        } else if segue.identifier == "etcSegue" {
            vc.navigationItem.title = "기타"
            vc.dishCategory = 3
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @objc func presentProteinWebView() {
        
        Analytics.logEvent("ProteinWebView_iOS", parameters: ["req": "ProteinWebView_iOS"])
        
        guard let url = URL(string: "https://www.gobsn.com/en-us/product/syntha6") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
        self.present(safariViewController, animated: true, completion: nil)
    }

}
extension FoodVC: FSCalendarDelegate, FSCalendarDataSource {
    
    // 시작 날짜 지정
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "2020-01-01")!
    }
    // 끝 날짜 지정
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "2100-12-31")!
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        self.breakfastFoodList.removeAll()
        self.lunchFoodList.removeAll()
        self.dinnerFoodList.removeAll()
        self.etcFoodList.removeAll()
        
        self.reloadTableView()
        self.updateCircleProgressBar()
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        self.date = self.dateFormatter.string(from: date)
        
//        if self.dateFormatter.string(from: date) != self.dateFormatter.string(from: Date()) {
//            self.breakfastFoodAddButton.isHidden = true
//            self.lunchFoodAddButton.isHidden = true
//            self.dinnerFoodAddButton.isHidden = true
//            self.etcFoodAddButton.isHidden = true
//        } else {
//            self.breakfastFoodAddButton.isHidden = false
//            self.lunchFoodAddButton.isHidden = false
//            self.dinnerFoodAddButton.isHidden = false
//            self.etcFoodAddButton.isHidden = false
//        }
        
        let dataManager = FoodDataManager()
        dataManager.retrieveFoodList(fromVC: self, date: self.dateFormatter.string(from: date))
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}
extension FoodVC: UITableViewDelegate, UITableViewDataSource {
    
    @objc func pressDeleteButton(_ sender: UIButton) {
        let tmp: Int = sender.tag / 1000
        let index: Int = sender.tag % 1000
        
        let foodDataManager = FoodDataManager()
        
        if tmp == 1 {
            print("breakfast")
            print(index)
            foodDataManager.deleteFood(fromVC: self, foodNo: self.breakfastFoodList[index].foodNo)
            self.breakfastFoodList.remove(at: index)
            self.breakfastFoodTableView.reloadData()
        } else if tmp == 2 {
            print("lunch")
            print(index)
            foodDataManager.deleteFood(fromVC: self, foodNo: self.lunchFoodList[index].foodNo)
            self.lunchFoodList.remove(at: index)
            self.lunchFoodTableView.reloadData()
        } else if tmp == 3 {
            print("dinner")
            print(index)
            foodDataManager.deleteFood(fromVC: self, foodNo: self.dinnerFoodList[index].foodNo)
            self.dinnerFoodList.remove(at: index)
            self.dinnerFoodTableView.reloadData()
        } else if tmp == 4 {
            print("etc")
            print(index)
            foodDataManager.deleteFood(fromVC: self, foodNo: self.etcFoodList[index].foodNo)
            self.etcFoodList.remove(at: index)
            self.etcFoodTableView.reloadData()
        }
        
        self.updateCircleProgressBar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case self.breakfastFoodTableView:
            self.setBreakfastView(heightValue: CGFloat(self.breakfastFoodList.count * 40))
            return self.breakfastFoodList.count
        case self.lunchFoodTableView:
            self.setLunchView(heightValue: CGFloat(self.lunchFoodList.count * 40))
            return self.lunchFoodList.count
        case self.dinnerFoodTableView:
            self.setDinnerView(heightValue: CGFloat(self.dinnerFoodList.count * 40))
            return self.dinnerFoodList.count
        case self.etcFoodTableView:
            self.setEtcView(heightValue: CGFloat(self.etcFoodList.count * 40))
            return self.etcFoodList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as? FoodCell else {
            return UITableViewCell()
        }

        switch tableView {
        case self.breakfastFoodTableView:
            cell.foodNameLabel.text = self.breakfastFoodList[indexPath.row].foodName
            cell.calorieLabel.text = "\((round(self.breakfastFoodList[indexPath.row].calorie * 10) / 10) * self.breakfastFoodList[indexPath.row].serving)Kcal"
            cell.deleteButton.tag = indexPath.row + 1000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        case self.lunchFoodTableView:
            cell.foodNameLabel.text = self.lunchFoodList[indexPath.row].foodName
            cell.calorieLabel.text = "\((round(self.lunchFoodList[indexPath.row].calorie * 10) / 10) * self.lunchFoodList[indexPath.row].serving)Kcal"
            cell.deleteButton.tag = indexPath.row + 2000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        case self.dinnerFoodTableView:
            cell.foodNameLabel.text = self.dinnerFoodList[indexPath.row].foodName
            cell.calorieLabel.text = "\((round(self.dinnerFoodList[indexPath.row].calorie * 10) / 10) * self.dinnerFoodList[indexPath.row].serving)Kcal"
            cell.deleteButton.tag = indexPath.row + 3000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        case self.etcFoodTableView:
            cell.foodNameLabel.text = self.etcFoodList[indexPath.row].foodName
            cell.calorieLabel.text = "\((round(self.etcFoodList[indexPath.row].calorie * 10) / 10) * self.etcFoodList[indexPath.row].serving)Kcal"
            cell.deleteButton.tag = indexPath.row + 4000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
extension FoodVC: AddFoodDelegate {
    func addFoodToFoolList() -> FoodVC {
        return self
    }
}
