//
//  ExerciseDataManager.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/06/14.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class ExerciseDataManager {
    
    func addExercise(fromVC vc: ExerciseVC, exercise: Exercise, date: String) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        
        let parameters: Parameters = [
            "exerciseName": exercise.name,
            "exercisePart": exercise.exercisePart,
            "setNo": exercise.set as Any,
            "repeatNo": exercise.lap as Any,
            "min": exercise.minute as Any,
            "intensity": exercise.intensity as Any,
            "recordDate": date
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/exercise", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    print(defaultResponse)
                    self.retrieveExerciseList(fromVC: vc, date: date)
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func deleteExercise(fromVC vc: ExerciseVC, number: Int) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "Content-Type": "application/json",
            "x-access-token": signInToken
        ]
        let parameters: Parameters = [
            "exerciseNo": number
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/exercise", method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
            .responseObject(completionHandler: { (response: DataResponse<DefaultResponse>) in
                switch response.result {
                case .success(let defaultResponse):
                    print(defaultResponse)
                    vc.reloadTableView()
                case .failure(let error):
                    print(error)
                }
            })
    }
    
    func retrieveExerciseList(fromVC vc: ExerciseVC, date: String) {
        guard let signInToken = UserDefaults.standard.string(forKey: "LoginToken") else {
            vc.presentAlert(title: "로그인 만료", message: "로그인이 만료되었습니다. 재로그인 해주세요.")
            return
        }
        let headers = [
            "x-access-token": signInToken
        ]
        
        Alamofire.request("\(ApiAddress.default)/user/exercise?recordDate=\(date)", method: .get, headers: headers)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ExerciseResponse>) in
                switch response.result {
                case .success(let exerciseResponse):
                    print(exerciseResponse)
                    
                    vc.muscleExerciseList.removeAll()
                    vc.normalExerciseList.removeAll()
                    
                    vc.reloadTableView()
                    guard let exerciseList = exerciseResponse.result else {
                        return
                    }
                    for exercise in exerciseList {
                        if exercise.exercisePart == 1 {
                            vc.muscleExerciseList.append(Exercise(no: exercise.exerciseNo, name: exercise.exerciseName, part: exercise.exercisePart, lap: nil, set: nil, minute: exercise.minute, intensity: exercise.intensity))
                            
                        } else if exercise.exercisePart == 2 {
                            vc.muscleExerciseList.append(Exercise(no: exercise.exerciseNo, name: exercise.exerciseName, part: exercise.exercisePart, lap: exercise.lap, set: exercise.set, minute: nil, intensity: nil))
                        }
                    }
                    
                    vc.reloadTableView()
                case .failure(let error):
                    print(error)
                }
            })
    }
}
