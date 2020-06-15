//
//  SettingDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class SettingDataManager {
    
    func retrieveProfile(fromVC vc: SettingVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/profile", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ProfileResponse>) in
                switch response.result {
                case .success(let profile):
                    print(profile)
                    
                    guard let gender = profile.result[0].gender,
                        let birthDate = profile.result[0].birthDate,
                        let height = profile.result[0].height,
                        let weight = profile.result[0].weight else {
                            return
                    }
                    
                    vc.gender = gender
                    vc.birthDate = birthDate
                    vc.height = height
                    vc.weight = weight
                    
                    let dateFormatter = DateFormatter()
                    let dateFormatterForReq = DateFormatter()
                    dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                    dateFormatterForReq.dateFormat = "yyyy-MM-dd"
                    //                    dateFormatterForReq.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    
                    let date = dateFormatterForReq.date(from: birthDate)!
                    
                    if gender == 1 {
                        vc.settingGenderLabel.text = "남성"
                    } else if gender == 2 {
                        vc.settingGenderLabel.text = "여성"
                    }
                    
                    vc.settingBirthDateLabel.text = "\(dateFormatter.string(from: date))"
                    vc.settingHeightLabel.text = "\(height)cm"
                    vc.settingWeightLabel.text = "\(weight)Kg"
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func setHeight(fromVC vc: SettingVC, height: Double) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        var gender: Int {
            get {
                if vc.gender == 0 {
                    return 1
                } else {
                    return vc.gender
                }
            }
        }
        
        let parameters: Parameters = [
            "height": height,
            "weight": vc.weight,
            "birth": vc.birthDate,
            "gender": gender
        ]
        
        Alamofire.request("\(ApiAddress.default)/updateProfile", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func setWeight(fromVC vc: SettingVC, weight: Double) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        
        var gender: Int {
            get {
                if vc.gender == 0 {
                    return 1
                } else {
                    return vc.gender
                }
            }
        }
        
        let parameters: Parameters = [
            "height": vc.height,
            "weight": weight,
            "birth": vc.birthDate,
            "gender": gender
        ]
        
        Alamofire.request("\(ApiAddress.default)/updateProfile", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func setBirthDate(fromVC vc: SettingVC, birthDate: String) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        
        var gender: Int {
            get {
                if vc.gender == 0 {
                    return 1
                } else {
                    return vc.gender
                }
            }
        }
        
        let parameters: Parameters = [
            "height": vc.height,
            "weight": vc.weight,
            "birth": birthDate,
            "gender": gender
        ]
        
        Alamofire.request("\(ApiAddress.default)/updateProfile", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func setGender(fromVC vc: SettingVC, gender: Int) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        let parameters: Parameters = [
            "height": vc.height,
            "weight": vc.weight,
            "birth": vc.birthDate,
            "gender": gender
        ]
        
        Alamofire.request("\(ApiAddress.default)/updateProfile", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func setGoalWeight(fromVC vc: SettingVC, weight: Double) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        let parameters: Parameters = [
            "goalWeight": weight
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/goalWeight", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func retrieveGoalWeight(fromVC vc: SettingVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/goalWeight", method: .get, headers: headers)
        .validate()
            .responseObject(completionHandler: { (response: DataResponse<GoalWeightResponse>) in
                switch response.result {
                case .success(let goalWeightResponse):
                    print(goalWeightResponse)
                    guard let startWeight = goalWeightResponse.result[0].startWeight,
                        let currentWeight = goalWeightResponse.result[0].currentWeight else { return }
                    
                    vc.settingStartWeightLabel.text = "\(startWeight)Kg"
                    vc.settingPresentWeightLabel.text = "\(currentWeight)Kg"
                    
                    guard let goalWeight = goalWeightResponse.result[0].goalWeight else { return }
                    
                    vc.settingGoalWeightLabel.text = "\(goalWeight)Kg"
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func setWeekGoal(fromVC vc: SettingVC, goal: Int) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        let parameters: Parameters = [
            "weekWeightGoal": goal
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/weekWeightGoal", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func retrieveWeekGoal(fromVC vc: SettingVC) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/weekWeightGoal", method: .get, headers: headers)
        .validate()
            .responseObject(completionHandler: { (response: DataResponse<WeekGoalResponse>) in
                switch response.result {
                case .success(let weekGoalResponse):
                    print(weekGoalResponse)
                    
                    guard let goal = weekGoalResponse.result[0].weekGoal else { return }
                    if goal == 1 {
                        vc.settingWeekGoalLabel.text = "주간 목표 - 주당 0.5Kg 감량"
                    } else if goal == 2 {
                        vc.settingWeekGoalLabel.text = "주간 목표 - 주당 0.2Kg 감량"
                    } else if goal == 3 {
                        vc.settingWeekGoalLabel.text = "주간 목표 - 주당 체중 유지"
                    } else if goal == 4 {
                        vc.settingWeekGoalLabel.text = "주간 목표 - 주당 0.2Kg 증량"
                    } else if goal == 5 {
                        vc.settingWeekGoalLabel.text = "주간 목표 - 주당 0.5Kg 증량"
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func setNutrition(fromVC vc: SettingVC, calorie: Int, carbohydrateRate: Int, proteinRate: Int, fatRate: Int) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        let parameters: Parameters = [
            "carboRate": carbohydrateRate,
            "proteinRate": proteinRate,
            "fatRate": fatRate,
            "goalCalorie": calorie
        ]
        
        print(parameters)
        
        Alamofire.request("\(ApiAddress.default)/user/goalNutrition", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
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
    
    func retrieveNutritionInfo(fromVC vc: SettingVC) {
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
                        vc.goalCalorie = info.goalCalorie
                        vc.carbohydrateRate = info.carbohydrateRate
                        vc.proteinRate = info.proteinRate
                        vc.fatRate = info.fatRate
                        
                        vc.settingGoalCalorieLabel.text = "\(vc.goalCalorie)Kcal"
                        vc.settingRatioLabel.text = "\(vc.carbohydrateRate) : \(vc.proteinRate) : \(vc.fatRate)"
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
    }
}
