//
//  AddFoodVC.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/07.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import SnapKit

class AddFoodVC: BaseVC {
    
    @IBOutlet weak var foodSearchTextField: UITextField!
    @IBOutlet weak var foodSearchButton: UIButton!
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    @IBOutlet weak var addFoodPopUpVC: UIView!
    @IBOutlet weak var addFoodPopUpVCBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var servingSizeDescriptionLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var backView: UIView!
    
    /// 몇인분인지 소수점 위로 나타내주는 PickerView
    @IBOutlet weak var mainAmountPickerView: UIPickerView!
    /// 몇인분인지 소수점 아래로 나타내주는 PickerView
    @IBOutlet weak var subAmountPickerView: UIPickerView!
    
    weak var addFoodDelegate: AddFoodDelegate?
    
    /*
     String menutitleList2[] = {"스테이크","연어","단백질파우더"};
     double menuKcalList2[] = {50,12,102,432.2,24,13,25,434.3,113,13,112,145.2};
     */
    
    var searchFoodList: [Food] = []
    
    var food: Food?
    var date: String = ""
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var dishCategory: Int = 0
    var isPopUp: Bool = false
    
    var mainAmountList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    var subAmountList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var mainAmount: Int = 0
    var subAmount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.foodSearchButton.addTarget(self, action: #selector(self.pressSearchFoodButton), for: .touchUpInside)
        
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
        
        self.searchResultTableView.register(UINib(nibName: "FoodSearchCell", bundle: nil), forCellReuseIdentifier: "FoodSearchCell")
        
        self.mainAmountPickerView.delegate = self
        self.mainAmountPickerView.dataSource = self
        self.subAmountPickerView.delegate = self
        self.subAmountPickerView.dataSource = self
        
        self.setAddFoodPopUpVC()
        self.confirmButton.addTarget(self, action: #selector(self.pressConfirmButton(_:)), for: .touchUpInside)
    }
    
    private func setAddFoodPopUpVC() {
        self.setShadow(view: self.addFoodPopUpVC, radius: 5.0, height: -3.0)
        self.addFoodPopUpVC.layer.cornerRadius = 15
        
//        let maskPath = UIBezierPath(roundedRect: self.addFoodPopUpVC.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15.0, height: 15.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = maskPath.cgPath
//        self.addFoodPopUpVC.layer.mask = maskLayer
    }
    
    @objc func pressSearchFoodButton() {
        if self.foodSearchTextField.text == "" {
            self.presentAlert(title: "음식명을 입력해주세요", message: "음식 이름을 입력해주세요")
        } else {
            guard let keyword = self.foodSearchTextField.text else { return }
            let addFoodDataManager = AddFoodDataManager()
            addFoodDataManager.searchFoodByKeyword(vc: self, keyword: keyword)
        }
    }
    
    @objc private func showAddFoodPopUpVC() {
        self.isPopUp = true
        self.tapGestureForDismissAddFoodPopUp()
        UIView.animate(withDuration: 0.5) {
            self.backView.isHidden = false
            self.setShadow(view: self.addFoodPopUpVC, radius: 5, height: -10)
            self.addFoodPopUpVCBottomConstraint.constant = -10
            self.view.layoutIfNeeded()
        }
    }
    
    private func tapGestureForDismissAddFoodPopUp() {
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissAddFoodPopUpVC))
        gesture.cancelsTouchesInView = false
        self.backView.addGestureRecognizer(gesture)
    }
    
    @objc private func dismissAddFoodPopUpVC() {
        self.hideKeyboardWhenTappedAround()
        UIView.animate(withDuration: 0.3) {
            self.backView.isHidden = true
            self.addFoodPopUpVCBottomConstraint.constant = -350
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func pressConfirmButton(_ sender: UIButton) {
        let multiple = Double("\(mainAmount).\(subAmount)")!
        if multiple == 0 {
            self.presentAlert(title: "입력오류", message: "똑바로 입력해주시기 바랍니다.")
            return
        }
//        self.food!.calorie = self.food!.calorie
//        self.food!.carbohydrate = self.food!.carbohydrate
//        self.food!.protein = self.food!.protein
//        self.food!.fat = self.food!.fat
//        self.food!.servingSize = self.food!.servingSize
        
        self.food?.serving = multiple
        
        guard let food = self.food else {
            self.presentAlert(title: "음식 오류", message: "음식이 잘못되었습니다")
            return
        }
        
        let dataManager = FoodDataManager()
        dataManager.addFood(fromVC: self, date: self.date, food: food, dish: self.dishCategory)
        
    }
}
extension AddFoodVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.mainAmountPickerView {
            return "\(self.mainAmountList[row])"
        } else if pickerView == self.subAmountPickerView {
            return "\(self.subAmountList[row])"
        }

        return "\(self.mainAmountList[row])"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.mainAmountPickerView {
            return self.mainAmountList.count
        } else if pickerView == self.subAmountPickerView {
            return self.subAmountList.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.mainAmountPickerView {
            self.mainAmount = self.mainAmountList[row]
        } else if pickerView == self.subAmountPickerView {
            self.subAmount = self.subAmountList[row]
        }
    }
}
extension AddFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchFood = self.searchFoodList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodSearchCell", for: indexPath) as? FoodSearchCell else { return UITableViewCell() }
        if let region = searchFood.region {
            cell.foodNameLabel.text = "\(searchFood.foodName)(\(region))"
        } else {
            cell.foodNameLabel.text = "\(searchFood.foodName)"
        }
        
        cell.foodDescriptionLabel.text = "탄수화물: \(searchFood.carbohydrate), 단백질: \(searchFood.protein), 지방: \(searchFood.fat)"
        cell.kaloryLabel.text = "\(searchFood.calorie) Kcal"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchFood = self.searchFoodList[indexPath.row]
        self.food = searchFood
        self.foodNameLabel.text = searchFood.foodName
        self.servingSizeDescriptionLabel.text = "메뉴 1회 제공량(\(searchFood.servingSize)g / 1인분)"
        self.showAddFoodPopUpVC()
    }
}
