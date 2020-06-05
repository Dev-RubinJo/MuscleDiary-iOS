//
//  FoodDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/03.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class FoodDataManager {
    
    func addFood(fromVC vc: AddFoodVC, date: String, food: Food, dish: Int) {
        guard let token = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "재로그인 해주시기 바랍니다.")
            return
        }
        let headers: [String: String] = ["x-access-token": token]
        let parameters: Parameters = [
            "foodName": food.foodName,
            "calorie": food.calorie,
            "carbohydrate": food.carbohydrate,
            "protein": food.protein,
            "fat": food.fat,
            "recordDate": date,
            "mealType": dish + 1,
            "serving": food.serving,
            "foodRegion": food.region ?? ""
        ]
        
        print(parameters)
        
        Alamofire.request("\(ApiAddress.default)/user/meal", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    print(defaultResponse)
                    let foodVC = vc.addFoodDelegate?.addFoodToFoolList()
                    if dish == 0 { // Breakfast
                        foodVC?.breakfastFoodList.append(food)
                    } else if dish == 1 { // Lunch
                        foodVC?.lunchFoodList.append(food)
                    } else if dish == 2 { // Dinner
                        foodVC?.dinnerFoodList.append(food)
                    } else if dish == 3 { // etc
                        foodVC?.etcFoodList.append(food)
                    }
                    
                    vc.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func deleteFood(fromVC vc: FoodVC, foodNo: Int) {
        guard let token = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "재로그인 해주시기 바랍니다.")
            return
        }
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "x-access-token": token
        ]
        let parameters: Parameters = ["menuNo": foodNo]
        
        Alamofire.request("\(ApiAddress.default)/user/meal", method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    print(defaultResponse)
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveFoodList(fromVC vc: FoodVC, date: String) {
        guard let token = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "재로그인 해주시기 바랍니다.")
            return
        }
        let headers: [String: String] = ["x-access-token": token]
        
        // 아침
        Alamofire.request("\(ApiAddress.default)/user/meal?mealType=1&recordDate=\(date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<FoodResponse>) in
                switch response.result {
                case .success(let foodResponse):
                    print(foodResponse)
                    guard let foodList = foodResponse.result else { return }
                    vc.breakfastFoodList.removeAll()
                    for food in foodList {
                        vc.breakfastFoodList.append(Food(no: food.foodNo, name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: nil, serving: food.servingSize, region: food.region))
                    }
                    
                    vc.breakfastFoodTableView.reloadData()
                    vc.updateCircleProgressBar()
                case .failure(let error):
                    print(error)
                }
            })
        
        // 점심
        Alamofire.request("\(ApiAddress.default)/user/meal?mealType=2&recordDate=\(date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<FoodResponse>) in
                switch response.result {
                case .success(let foodResponse):
                    print(foodResponse)
                    guard let foodList = foodResponse.result else { return }
                    vc.lunchFoodList.removeAll()
                    for food in foodList {
                        vc.lunchFoodList.append(Food(no: food.foodNo, name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: nil, serving: food.servingSize, region: food.region))
                    }
                    vc.lunchFoodTableView.reloadData()
                    vc.updateCircleProgressBar()
                case .failure(let error):
                    print(error)
                }
            })
        
        // 저녁
        Alamofire.request("\(ApiAddress.default)/user/meal?mealType=2&recordDate=\(date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<FoodResponse>) in
                switch response.result {
                case .success(let foodResponse):
                    print(foodResponse)
                    guard let foodList = foodResponse.result else { return }
                    vc.dinnerFoodList.removeAll()
                    for food in foodList {
                        vc.dinnerFoodList.append(Food(no: food.foodNo, name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: nil, serving: food.servingSize, region: food.region))
                    }
                    vc.dinnerFoodTableView.reloadData()
                    vc.updateCircleProgressBar()
                case .failure(let error):
                    print(error)
                }
            })
        
        // 기타
        Alamofire.request("\(ApiAddress.default)/user/meal?mealType=2&recordDate=\(date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<FoodResponse>) in
                switch response.result {
                case .success(let foodResponse):
                    print(foodResponse)
                    guard let foodList = foodResponse.result else { return }
                    vc.etcFoodList.removeAll()
                    for food in foodList {
                        vc.etcFoodList.append(Food(no: food.foodNo, name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: nil, serving: food.servingSize, region: food.region))
                    }
                    vc.etcFoodTableView.reloadData()
                    vc.updateCircleProgressBar()
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveNutritionInfo(fromVC vc: FoodVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/goalNutrition", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<NutritionResponse>) in
                switch response.result {
                case .success(let nutritionResponse):
                    if nutritionResponse.code == 102 {
                        let info = nutritionResponse.result[0]
                        
                        let carbohydrate = Double(info.goalCalorie) * (Double(info.carbohydrateRate) / 100) / 4
                        let protein = Double(info.goalCalorie) * (Double(info.proteinRate) / 100) / 4
                        let fat = Double(info.goalCalorie) * (Double(info.fatRate) / 100) / 9
                        
                        vc.recommendCarbohydrate = carbohydrate
                        vc.recommendProtein = protein
                        vc.recommendFat = fat
                        
                        vc.targetCalorie = Double(info.goalCalorie)
                        vc.targetCalorieLabel.text = "\(Double(info.goalCalorie))"
                        vc.setCircleProgressView(time: 0.01)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
}
//        for type in 1 ... 4 {
//            Alamofire.request("\(ApiAddress.default)/user/meal?mealType=\(type)&recordDate=\(date)", method: .get, headers: headers)
//                .validate()
//                .responseObject(completionHandler: { (response: DataResponse<FoodResponse>) in
//                    switch response.result {
//                    case .success(let foodResponse):
//                        print(foodResponse)
//                        guard let foodList = foodResponse.result else { return }
//                        if type == 1 {
//                            for food in foodList {
//                                vc.breakfastFoodList.append(Food(name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: food.servingSize, region: food.region))
//                            }
//                        } else if type == 2 {
//                            for food in foodList {
//                                vc.lunchFoodList.append(Food(name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: food.servingSize, region: food.region))
//                            }
//                        } else if type == 3 {
//                            for food in foodList {
//                                vc.dinnerFoodList.append(Food(name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: food.servingSize, region: food.region))
//                            }
//                        } else if type == 4 {
//                            for food in foodList {
//                                vc.etcFoodList.append(Food(name: food.foodName, carbohydrate: food.carbohydrate!, protein: food.protein!, fat: food.fat!, calorie: food.calorie!, servingSize: food.servingSize, region: food.region))
//                            }
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
//        }
