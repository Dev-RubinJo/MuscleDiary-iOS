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
    
    @IBOutlet weak var proteinView: UIView!
    @IBOutlet weak var proteinCircleProgressView: CircularProgressView!
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var proteinAdvertiseView: UIView!
    @IBOutlet weak var proteinAdvertiseViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fatView: UIView!
    @IBOutlet weak var fatCircleProgressView: CircularProgressView!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var breakfastView: UIView!
    @IBOutlet weak var breakfastViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var lunchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var dinnerViewHeightConstraint: NSLayoutConstraint!
    
    var carbohydrate: Float = 0.0
    var protein: Float = 0.0
    var fat: Float = 0.0
    
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
        self.carbohydrateCircleProgressView.progressAnimation(duration: 0.01, value: self.carbohydrate / 120, color: .purple)
        self.carbohydrateLabel.text = "\(self.carbohydrate)"
        
        self.proteinCircleProgressView.progressAnimation(duration: 0.01, value: self.protein / 120, color: .green)
        self.proteinLabel.text = "\(self.protein)"
        
        self.fatCircleProgressView.progressAnimation(duration: 0.01, value: self.fat / 100, color: .yellow)
        self.fatLabel.text = "\(self.fat)"
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
