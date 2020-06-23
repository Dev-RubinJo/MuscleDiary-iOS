//
//  SettingVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/02.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var settingGenderView: UIView!
    @IBOutlet weak var settingGenderLabel: UILabel!
    
    @IBOutlet weak var settingBirthDateView: UIView!
    @IBOutlet weak var settingBirthDateLabel: UILabel!
    
    @IBOutlet weak var settingHeightView: UIView!
    @IBOutlet weak var settingHeightLabel: UILabel!
    
    @IBOutlet weak var settingWeightView: UIView!
    @IBOutlet weak var settingWeightLabel: UILabel!
    
    @IBOutlet weak var settingStartWeightLabel: UILabel!
    @IBOutlet weak var settingPresentWeightLabel: UILabel!
    @IBOutlet weak var settingGoalWeightLabel: UILabel!
    
    /// - description: 주간 목표 설정 레이블
    @IBOutlet weak var settingWeekGoalLabel: UILabel!
    
    // 목표 칼로리 설정
    @IBOutlet weak var settingGoalCalorieLabel: UILabel!
    
    // 탄단지 비율 설정하기
    @IBOutlet weak var settingRatioLabel: UILabel!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    var window: UIWindow?
    
    var gender: Int = 0
    var birthDate: String = "1900-01-01"
    var height: Double = 0.0
    var weight: Double = 0.0
    
    var goal: Int = 0
    var goalCalorie: Int = 0
    var carbohydrateRate: Int = 0
    var proteinRate: Int = 0
    var fatRate: Int = 0
    
    var datePicker:UIDatePicker = UIDatePicker()
    let toolBar = UIToolbar()
    
    let settingDataManager = SettingDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setProfileSection()
        self.setGoalWeightSection()
        self.setGoalSection()
        
        self.signOutButton.layer.borderColor = UIColor.gray.cgColor
        self.signOutButton.layer.borderWidth = 1
        self.signOutButton.addTarget(self, action: #selector(self.pressSignOutButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.settingDataManager.retrieveProfile(fromVC: self)
        self.settingDataManager.retrieveGoalWeight(fromVC: self)
        self.settingDataManager.retrieveWeekGoal(fromVC: self)
        self.settingDataManager.retrieveNutritionInfo(fromVC: self)
    }
    
    private func setProfileSection() {
        let didTapSettingGenderView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingGenderView))
        self.settingGenderView.isUserInteractionEnabled = true
        self.settingGenderView.addGestureRecognizer(didTapSettingGenderView)
        
        let didTapSettingBirthDateView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingBirthDateView))
        self.settingBirthDateView.isUserInteractionEnabled = true
        self.settingBirthDateView.addGestureRecognizer(didTapSettingBirthDateView)
        
        let didTapSettingHeightView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingHeightView))
        self.settingHeightView.isUserInteractionEnabled = true
        self.settingHeightView.addGestureRecognizer(didTapSettingHeightView)
        
        let didTapSettingWeightView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingWeightView))
        self.settingWeightView.isUserInteractionEnabled = true
        self.settingWeightView.addGestureRecognizer(didTapSettingWeightView)
    }
    
    @objc func pressSettingGenderView() {
        let alert: UIAlertController = UIAlertController(title: "성별 선택", message: nil, preferredStyle: .actionSheet)
        let male = UIAlertAction(title: "남성", style: .default) { _ in
            self.gender = 1
            self.settingGenderLabel.text = "남성"
            
            self.settingDataManager.setGender(fromVC: self, gender: self.gender)
        }
        let female = UIAlertAction(title: "여성", style: .default) { _ in
            self.gender = 2
            self.settingGenderLabel.text = "여성"
            
            self.settingDataManager.setGender(fromVC: self, gender: self.gender)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        alert.addAction(male)
        alert.addAction(female)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSettingBirthDateView() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { (make) in
            make.centerX.equalTo(alert.view)
            make.top.equalTo(alert.view).offset(8)
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            let dateFormatterForReq = DateFormatter()
            dateFormatter.dateFormat = "yyyy년MM월dd일"
            dateFormatterForReq.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePicker.date)
            let dateStringForReq = dateFormatterForReq.string(from: datePicker.date)
            self.birthDate = dateStringForReq
            self.settingBirthDateLabel.text = dateString
            
            self.settingDataManager.setBirthDate(fromVC: self, birthDate: self.birthDate)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSettingHeightView() {
        let alert = UIAlertController(title: "키 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if alert.textFields![0].text != "" {
                self.height = Double(alert.textFields![0].text!)!
                self.settingHeightLabel.text = "\(alert.textFields![0].text!)cm"
            }
            
            self.settingDataManager.setHeight(fromVC: self, height: self.height)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSettingWeightView() {
        let alert = UIAlertController(title: "몸무게 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if alert.textFields![0].text != "" {
                self.weight = Double(alert.textFields![0].text!)!
                self.settingWeightLabel.text = "\(alert.textFields![0].text!)Kg"
            }
            self.settingDataManager.setWeight(fromVC: self, weight: self.weight)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setGoalWeightSection() {
//        시작 체중 설정 부분
//        let didTapSettingStartWeightLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingStartWeight))
//        self.settingStartWeightLabel.isUserInteractionEnabled = true
//        self.settingStartWeightLabel.addGestureRecognizer(didTapSettingStartWeightLabel)
//
//        현재 체중 설정 부분
//        let didTapSettingPresentWeightLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingPresentWeight))
//        self.settingPresentWeightLabel.isUserInteractionEnabled = true
//        self.settingPresentWeightLabel.addGestureRecognizer(didTapSettingPresentWeightLabel)
        
        let didTapSettingGoalWeightLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingGoalWeight))
        self.settingGoalWeightLabel.isUserInteractionEnabled = true
        self.settingGoalWeightLabel.addGestureRecognizer(didTapSettingGoalWeightLabel)
        
        let didTapSettingWeekGoalLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingWeekGoal))
        self.settingWeekGoalLabel.isUserInteractionEnabled = true
        self.settingWeekGoalLabel.addGestureRecognizer(didTapSettingWeekGoalLabel)
    }
    
//    @objc func pressSettingStartWeight() {
//        let alert = UIAlertController(title: "시작 체중 입력", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.keyboardType = .decimalPad
//        }
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            if alert.textFields![0].text != "" {
//                self.settingStartWeightLabel.text = "시작체중 - \(alert.textFields![0].text!)Kg"
//            }
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    @objc func pressSettingPresentWeight() {
//        let alert = UIAlertController(title: "현재 체중 입력", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.keyboardType = .decimalPad
//        }
//        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//            if alert.textFields![0].text != "" {
//                self.settingPresentWeightLabel.text = "현재 체중 - \(alert.textFields![0].text!)Kg"
//            }
//        }
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
//
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true, completion: nil)
//    }
    
    @objc func pressSettingGoalWeight() {
        let alert = UIAlertController(title: "목표 체중 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .decimalPad
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if alert.textFields![0].text != "" {
                self.settingGoalWeightLabel.text = "목표 체중 - \(alert.textFields![0].text!)Kg"
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSettingWeekGoal() {
        let alert: UIAlertController = UIAlertController(title: "주간 목표 선택", message: nil, preferredStyle: .actionSheet)
        let week05m = UIAlertAction(title: "주당 0.5Kg 감량", style: .default) { _ in
            self.goal = 1
            self.settingWeekGoalLabel.text = "주간 목표 - 주당 0.5Kg 감량"
            self.goalCalorie = Int(Double(self.goalCalorie) * 0.8)
            if self.goalCalorie != 0 {
                self.settingGoalCalorieLabel.text = "\(self.goalCalorie)Kcal"
            }
            self.settingDataManager.setWeekGoal(fromVC: self, goal: 1)
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let week02m = UIAlertAction(title: "주당 0.2Kg 감량", style: .default) { _ in
            self.goal = 2
            self.settingWeekGoalLabel.text = "주간 목표 - 주당 0.2Kg 감량"
            self.goalCalorie = Int(Double(self.goalCalorie) * 0.9)
            if self.goalCalorie != 0 {
                self.settingGoalCalorieLabel.text = "\(self.goalCalorie)Kcal"
            }
            self.settingDataManager.setWeekGoal(fromVC: self, goal: 2)
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let weekKeep = UIAlertAction(title: "주당 체중 유지", style: .default) { _ in
            self.goal = 3
            self.settingWeekGoalLabel.text = "주간 목표 - 주당 체중 유지"
            self.settingDataManager.setWeekGoal(fromVC: self, goal: 3)
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let week02p = UIAlertAction(title: "주당 0.2Kg 증량", style: .default) { _ in
            self.goal = 4
            self.settingWeekGoalLabel.text = "주간 목표 - 주당 0.2Kg 증량"
            self.goalCalorie = Int(Double(self.goalCalorie) * 1.1)
            if self.goalCalorie != 0 {
                self.settingGoalCalorieLabel.text = "\(self.goalCalorie)Kcal"
            }
            self.settingDataManager.setWeekGoal(fromVC: self, goal: 4)
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let week05p = UIAlertAction(title: "주당 0.5Kg 증량", style: .default) { _ in
            self.goal = 5
            self.settingWeekGoalLabel.text = "주간 목표 - 주당 0.5Kg 증량"
            self.goalCalorie = Int(Double(self.goalCalorie) * 1.2)
            if self.goalCalorie != 0 {
                self.settingGoalCalorieLabel.text = "\(self.goalCalorie)Kcal"
            }
            self.settingDataManager.setWeekGoal(fromVC: self, goal: 5)
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        alert.addAction(week05m)
        alert.addAction(week02m)
        alert.addAction(weekKeep)
        alert.addAction(week02p)
        alert.addAction(week05p)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setGoalSection() {
        let didTapSettingGoalCalorieLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingGoalCalorieLabel))
        self.settingGoalCalorieLabel.isUserInteractionEnabled = true
        self.settingGoalCalorieLabel.addGestureRecognizer(didTapSettingGoalCalorieLabel)
        
        let didTapSettingRatioLabel: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.pressSettingRatioLabel))
        self.settingRatioLabel.isUserInteractionEnabled = true
        self.settingRatioLabel.addGestureRecognizer(didTapSettingRatioLabel)
    }
    
    @objc func pressSettingGoalCalorieLabel() {
        let alert = UIAlertController(title: "목표 칼로리 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let text = alert.textFields![0].text {
                self.settingGoalCalorieLabel.text = "\(text)Kcal"
                self.goalCalorie = Int(text)!
                self.settingDataManager.setNutrition(fromVC: self, calorie: Int(text)!, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressSettingRatioLabel() {
        let alert: UIAlertController = UIAlertController(title: "탄단지 비율 선택(탄:단:지)", message: nil, preferredStyle: .actionSheet)
        let ratioGeneral = UIAlertAction(title: "일반적 비율: 50:30:20", style: .default) { _ in
            self.settingRatioLabel.text = "50 : 30 : 20"
            self.carbohydrateRate = 50
            self.proteinRate = 30
            self.fatRate = 20
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let ratioDiat = UIAlertAction(title: "다이어트 비율: 30:40:30", style: .default) { _ in
            self.settingRatioLabel.text = "30 : 40 : 30"
            self.carbohydrateRate = 30
            self.proteinRate = 40
            self.fatRate = 30
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        let ratioBulkUp = UIAlertAction(title: "벌크업 비율: 40:40:20", style: .default) { _ in
            self.settingRatioLabel.text = "40 : 40 : 20"
            self.carbohydrateRate = 40
            self.proteinRate = 40
            self.fatRate = 20
            self.settingDataManager.setNutrition(fromVC: self, calorie: self.goalCalorie, carbohydrateRate: self.carbohydrateRate, proteinRate: self.proteinRate, fatRate: self.fatRate)
        }
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in }
        
        alert.addAction(ratioGeneral)
        alert.addAction(ratioDiat)
        alert.addAction(ratioBulkUp)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    
    @objc func pressSignOutButton() {
        UserDefaults.standard.removeObject(forKey: "LoginToken")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInVC = mainStoryboard.instantiateViewController(withIdentifier: "SignInVC")
        UIApplication.shared.windows.first?.rootViewController = signInVC
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
//extension SettingVC: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        var inputValue = ""
//        if textField.tag == 100 {
//            guard let textFieldText = textField.text,
//                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
//                    return false
//            }
//            let substringToReplace = textFieldText[rangeOfTextToReplace]
//            let count = textFieldText.count - substringToReplace.count + string.count
//            if count > 4 {
//
//
//                return false
//            }
//
//        } else if textField.tag == 200 {
//            guard let textFieldText = textField.text,
//                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
//                    return false
//            }
//            let substringToReplace = textFieldText[rangeOfTextToReplace]
//            let count = textFieldText.count - substringToReplace.count + string.count
//            return count <= 2
//
//        } else if textField.tag == 300 {
//            guard let textFieldText = textField.text,
//                let rangeOfTextToReplace = Range(range, in: textFieldText) else {
//                    return false
//            }
//            let substringToReplace = textFieldText[rangeOfTextToReplace]
//            let count = textFieldText.count - substringToReplace.count + string.count
//            return count <= 2
//        }
//
////        && Int(textField.text!)! < 31
//
//        return true
//    }
//}
