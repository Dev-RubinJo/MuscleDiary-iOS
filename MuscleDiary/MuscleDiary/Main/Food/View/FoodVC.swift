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

class FoodVC: BaseVC {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    @IBOutlet weak var caloryInfoView: UIView!
    @IBOutlet weak var targetCaloryLabel: UILabel!
    @IBOutlet weak var gainCaloryLabel: UILabel!
    @IBOutlet weak var remainCaloryLabel: UILabel!
    
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
    
    @IBOutlet weak var breakfastView: UIView!
    @IBOutlet weak var breakfastViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breakfastTotalCaloryLabel: UILabel!
    @IBOutlet weak var breakfastFoodAddButton: UIButton!
    @IBOutlet weak var breakfastFoodTableView: UITableView!
        
    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var lunchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lunchTotalCaloryLabel: UILabel!
    @IBOutlet weak var lunchFoodAddButton: UIButton!
    @IBOutlet weak var lunchFoodTableView: UITableView!
    
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var dinnerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dinnerTotalCaloryLabel: UILabel!
    @IBOutlet weak var dinnerFoodAddButton: UIButton!
    @IBOutlet weak var dinnerFoodTableView: UITableView!
    
    var carbohydrate: Double = 0
    var protein: Double = 0
    var fat: Double = 0
    
    var recommendCarbohydrate: Double = 120
    var recommendProtein: Double = 120
    var recommendFat: Double = 100
    
    var breakfastFoodList: [Food] = [
        Food(name: "초콜릿", carbohydrate: 30, protein: 12, fat: 50, calory: 100, servingSize: 100),
        Food(name: "test", carbohydrate: 30, protein: 12, fat: 50, calory: 100, servingSize: 100),
        Food(name: "deser", carbohydrate: 30, protein: 12, fat: 50, calory: 100, servingSize: 100)
    ]
    var lunchFoodList: [Food] = [Food(name: "초콜릿", carbohydrate: 30, protein: 12, fat: 50, calory: 100, servingSize: 100)]
    var dinnerFoodList: [Food] = [Food(name: "초콜릿", carbohydrate: 30, protein: 12, fat: 50, calory: 100, servingSize: 100)]
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.caloryInfoView.layer.cornerRadius = 20
        self.initFsCalendar()
        self.setCircleProgressView()
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func initFsCalendar() {
        self.fsCalendar.clipsToBounds = true
        self.fsCalendar.select(Date())
        
        self.fsCalendar.scope = .week
        self.fsCalendar.isUserInteractionEnabled = true
        
        self.fsCalendar.delegate = self
        self.fsCalendar.dataSource = self
    }
    
    private func setCircleProgressView() {
        self.carbohydrateCircleProgressView.progressAnimation(duration: 0.01, value: self.carbohydrate / self.recommendCarbohydrate, color: .purple)
        self.carbohydrateLabel.text = "\(Int(self.carbohydrate))"
        self.recommendCarbohydrateLabel.text = "\(Int(self.recommendCarbohydrate))"
        
        self.proteinCircleProgressView.progressAnimation(duration: 0.01, value: self.protein / self.recommendProtein, color: .green)
        self.proteinLabel.text = "\(Int(self.protein))"
        self.recommendProteinLabel.text = "\(Int(self.recommendProtein))"
        
        if self.protein >= self.recommendProtein {
            self.setAdView(isOn: false)
        } else {
            self.setAdView(isOn: true)
        }
        
        self.fatCircleProgressView.progressAnimation(duration: 0.01, value: self.fat / self.recommendFat, color: .yellow)
        self.fatLabel.text = "\(Int(self.fat))"
        self.recommendFatLabel.text = "\(Int(self.recommendFat))"
    }
    
    private func setAdView(isOn: Bool) {
        if isOn {
            self.proteinAdvertiseViewHeightConstraint.constant = 100
        } else {
            self.proteinAdvertiseViewHeightConstraint.constant = 0
        }
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
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "breakfastSegue" {
            guard let vc = segue.destination as? AddFoodVC else { return }
            vc.navigationItem.title = "아침"
            vc.dishCategory = 0
        } else if segue.identifier == "lunchSegue" {
            guard let vc = segue.destination as? AddFoodVC else { return }
            vc.navigationItem.title = "점심"
            vc.dishCategory = 1
        } else if segue.identifier == "dinnerSegue" {
            guard let vc = segue.destination as? AddFoodVC else { return }
            vc.navigationItem.title = "저녁"
            vc.dishCategory = 2
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
extension FoodVC: FSCalendarDelegate, FSCalendarDataSource {
    
    // 시작 날짜 지정
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "20200101")!
    }
    // 끝 날짜 지정
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "21001231")!
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}
extension FoodVC: UITableViewDelegate, UITableViewDataSource {
    
    @objc func pressDeleteButton(_ sender: UIButton) {
        let tmp: Int = sender.tag / 1000
        let index: Int = sender.tag % 1000
        if tmp == 1 {
            print("breakfast")
            print(index)
            
            self.breakfastFoodList.remove(at: index)
            self.breakfastFoodTableView.reloadData()
        } else if tmp == 2 {
            print("lunch")
            print(index)
            self.lunchFoodList.remove(at: index)
            self.lunchFoodTableView.reloadData()
        } else if tmp == 3 {
            print("dinner")
            print(index)
            self.dinnerFoodList.remove(at: index)
            self.dinnerFoodTableView.reloadData()
        }
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
            cell.caloryLabel.text = "\(self.breakfastFoodList[indexPath.row].calory)Kcal"
            cell.deleteButton.tag = indexPath.row + 1000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        case self.lunchFoodTableView:
            cell.foodNameLabel.text = self.lunchFoodList[indexPath.row].foodName
            cell.caloryLabel.text = "\(self.lunchFoodList[indexPath.row].calory)Kcal"
            cell.deleteButton.tag = indexPath.row + 2000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteButton(_:)), for: .touchUpInside)
            return cell
        case self.dinnerFoodTableView:
            cell.foodNameLabel.text = self.dinnerFoodList[indexPath.row].foodName
            cell.caloryLabel.text = "\(self.dinnerFoodList[indexPath.row].calory)Kcal"
            cell.deleteButton.tag = indexPath.row + 3000
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
    func addFoodToFoolList(food: Food) {
        
    }
}
