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
    
    var searchFoodList: [Food] = [
        Food(name: "스테이크", carbohydrate: 50, protein: 12, fat: 102, calory: 432.2, servingSize: 100),
        Food(name: "연어", carbohydrate: 24, protein: 13, fat: 25, calory: 434.3, servingSize: 130),
        Food(name: "단백질 파우더", carbohydrate: 113, protein: 13, fat: 112, calory: 145.2, servingSize: 230)
    ]
    
    var dishCategory: Int = 0
    var isPopUp: Bool = false
    
    var mainAmountList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    var subAmountList: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var mainAmount: Int = 0
    var subAmount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainAmountPickerView.delegate = self
        self.mainAmountPickerView.dataSource = self
        self.subAmountPickerView.delegate = self
        self.subAmountPickerView.dataSource = self
        
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
        
        self.searchResultTableView.register(UINib(nibName: "FoodSearchCell", bundle: nil), forCellReuseIdentifier: "FoodSearchCell")
        
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
        print(Double("\(mainAmount).\(subAmount)"))
//        self.addFoodDelegate?.addFoodToFoolList(food: <#T##Food#>)
        self.navigationController?.popViewController(animated: true)
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
        
        cell.foodNameLabel.text = searchFood.foodName
        cell.foodDescriptionLabel.text = "탄수화물: \(searchFood.carbohydrate), 단백질: \(searchFood.protein), 지방: \(searchFood.fat)"
        cell.kaloryLabel.text = "\(searchFood.calory) Kcal"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchFood = self.searchFoodList[indexPath.row]
        self.foodNameLabel.text = searchFood.foodName
        self.servingSizeDescriptionLabel.text = "메뉴 1회 제공량(\(searchFood.servingSize)g / 1인분)"
        self.showAddFoodPopUpVC()
    }
    
}
