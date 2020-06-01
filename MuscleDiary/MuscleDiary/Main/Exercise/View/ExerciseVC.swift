//
//  ExerciseVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/02.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import FSCalendar

class ExerciseVC: BaseVC {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    @IBOutlet weak var muscleExerciseView: UIView!
    @IBOutlet weak var muscleExerciseViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var muscleExerciseTableView: UITableView!
    @IBOutlet weak var muscleExerciseAddButton: UIButton!
    
    @IBOutlet weak var normalExerciseView: UIView!
    @IBOutlet weak var normalExerciseViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var normalExerciseTableView: UITableView!
    @IBOutlet weak var normalExerciseAddButton: UIButton!
    
    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var lapMinuteLabel: UILabel!
    @IBOutlet weak var lapMinuteTextField: UITextField!
    @IBOutlet weak var setIntensityLabel: UILabel!
    @IBOutlet weak var setIntensityTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: String = ""
    
    var muscleExerciseList: [Exercise] = []
    var normalExerciseList: [Exercise] = []
    var type: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.date = self.dateFormatter.string(from: Date())
        
        self.reloadTableView()
        self.initTableView()
        self.initFsCalendar()
        self.initPopUp()
        
        let exerciseDataManager = ExerciseDataManager()
        exerciseDataManager.retrieveExerciseList(fromVC: self, date: self.date)
    }
    
    private func initTableView() {
        self.muscleExerciseTableView.delegate = self
        self.muscleExerciseTableView.dataSource = self
        
        self.normalExerciseTableView.delegate = self
        self.normalExerciseTableView.dataSource = self
    
        self.muscleExerciseTableView.register(ExerciseCell.self, forCellReuseIdentifier: "ExerciseCell")
        self.normalExerciseTableView.register(ExerciseCell.self, forCellReuseIdentifier: "ExerciseCell")
    }
    
    private func initFsCalendar() {
        self.fsCalendar.clipsToBounds = true
        self.fsCalendar.select(Date())
        
        self.fsCalendar.scope = .week
        self.fsCalendar.isUserInteractionEnabled = true
        
        self.fsCalendar.delegate = self
        self.fsCalendar.dataSource = self
    }
    
    func reloadTableView() {
        self.muscleExerciseTableView.reloadData()
        self.normalExerciseTableView.reloadData()
    }
    
    private func setMuscleExerciseView(heightValue: CGFloat) {
        self.muscleExerciseView.layer.cornerRadius = 5
        self.muscleExerciseViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func setNormalExerciseView(heightValue: CGFloat) {
        self.normalExerciseView.layer.cornerRadius = 5
        self.normalExerciseViewHeightConstraint.constant = 50 + heightValue
    }
    
    private func initPopUp() {
        self.muscleExerciseAddButton.addTarget(self, action: #selector(self.pressMuscleExerciseAddButton), for: .touchUpInside)
        self.normalExerciseAddButton.addTarget(self, action: #selector(self.pressNormalExerciseAddButton), for: .touchUpInside)
        
        self.popUpView.layer.cornerRadius = 5
        
        let didTapOutsideView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressOutsideView))
        self.outsideView.isUserInteractionEnabled = true
        self.outsideView.addGestureRecognizer(didTapOutsideView)
        
        self.okButton.addTarget(self, action: #selector(self.pressPopUpOkButton), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(self.pressPopUpCancelButton), for: .touchUpInside)
    }
    
    @objc func pressMuscleExerciseAddButton() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.outsideView.isHidden = false
        self.popUpView.isHidden = false
        
        self.lapMinuteLabel.text = "횟수 입력"
        self.setIntensityLabel.text = "세트 입력"
        
        self.type = 1
    }
    
    @objc func pressNormalExerciseAddButton() {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.outsideView.isHidden = false
        self.popUpView.isHidden = false
        
        self.lapMinuteLabel.text = "분 입력"
        self.setIntensityLabel.text = "강도 입력"
        
        self.type = 2
    }
    
    @objc func pressOutsideView() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.outsideView.isHidden = true
        self.popUpView.isHidden = true
    }
    
    @objc func pressPopUpOkButton() {
        let exerciseDataManager = ExerciseDataManager()
        
        if self.type == 1 { // 근력
            if self.exerciseNameTextField.text == "" || self.lapMinuteTextField.text == "" || self.setIntensityTextField.text == "" {
                self.presentAlert(title: "값을 입력해주세요", message: nil)
            } else {
                let exercise = Exercise(no: 0, name: self.exerciseNameTextField.text!, part: 2, lap: Int(self.lapMinuteTextField.text!), set: Int(self.setIntensityTextField.text!), minute: nil, intensity: nil)
                
                exerciseDataManager.addExercise(fromVC: self, exercise: exercise, date: self.date)
            }
        } else if self.type == 2 { // 유산소
            if self.exerciseNameTextField.text == "" || self.lapMinuteTextField.text == "" || self.setIntensityTextField.text == "" {
                self.presentAlert(title: "값을 입력해주세요", message: nil)
            } else {
                let exercise = Exercise(no: 0, name: self.exerciseNameTextField.text!, part: 1, lap: nil, set: nil, minute: Int(self.lapMinuteTextField.text!), intensity: Int(self.setIntensityTextField.text!))
                
                exerciseDataManager.addExercise(fromVC: self, exercise: exercise, date: self.date)
            }
        }
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.outsideView.isHidden = true
        self.popUpView.isHidden = true
        
        self.exerciseNameTextField.text = ""
        self.lapMinuteTextField.text = ""
        self.setIntensityTextField.text = ""
    }
    
    @objc func pressPopUpCancelButton() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.outsideView.isHidden = true
        self.popUpView.isHidden = true
    }
    
    @objc func pressDeleteExerciseButton(_ sender: UIButton) {
        let tmp: Int = sender.tag / 1000
        let index: Int = sender.tag % 1000
        
        let exerciseDataManager = ExerciseDataManager()
        
        if tmp == 1 {
            let exerciseNo = self.muscleExerciseList[index].exerciseNo
            exerciseDataManager.deleteExercise(fromVC: self, number: exerciseNo)
            self.muscleExerciseList.remove(at: index)
            
        } else if tmp == 2 {
            let exerciseNo = self.normalExerciseList[index].exerciseNo
            exerciseDataManager.deleteExercise(fromVC: self, number: exerciseNo)
            self.normalExerciseList.remove(at: index)
        }
    }
    
    // MARK: - Navigation
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
extension ExerciseVC: FSCalendarDelegate, FSCalendarDataSource {
    // 시작 날짜 지정
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "2020-01-01")!
    }
    // 끝 날짜 지정
    func maximumDate(for calendar: FSCalendar) -> Date {
        return self.dateFormatter.date(from: "2100-12-31")!
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        self.date = self.dateFormatter.string(from: date)
        
        let exerciseDataManager = ExerciseDataManager()
        exerciseDataManager.retrieveExerciseList(fromVC: self, date: self.date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}
extension ExerciseVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.muscleExerciseTableView {
            self.setMuscleExerciseView(heightValue: CGFloat(self.muscleExerciseList.count * 40))
            return self.muscleExerciseList.count
        } else if tableView == self.normalExerciseTableView {
            self.setNormalExerciseView(heightValue: CGFloat(self.normalExerciseList.count * 40))
            return self.normalExerciseList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as? ExerciseCell else {
            return UITableViewCell()
        }
        
        if tableView == self.muscleExerciseTableView {
            let data = self.muscleExerciseList[indexPath.row]
            cell.exerciseNameLabel.text = data.name
            cell.loopLabel.text = "\(data.lap!)(lap)/\(data.set!)(set)"
            cell.deleteButton.tag = indexPath.row + 1000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteExerciseButton(_:)), for: .touchUpInside)
        } else if tableView == self.normalExerciseTableView {
            let data = self.normalExerciseList[indexPath.row]
            cell.exerciseNameLabel.text = data.name
            cell.loopLabel.text = "\(data.minute!)(min)/\(data.intensity!)(int)"
            cell.deleteButton.tag = indexPath.row + 2000
            cell.deleteButton.addTarget(self, action: #selector(self.pressDeleteExerciseButton(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
