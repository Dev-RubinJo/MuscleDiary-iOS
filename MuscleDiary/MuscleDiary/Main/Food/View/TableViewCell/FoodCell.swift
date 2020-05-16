//
//  FoodCell.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/05/07.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import SnapKit

class FoodCell: UITableViewCell {
    
    var food: Food?
    
    /// 셀 내부의 컨테이너 뷰
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    lazy var caloryLabel: UILabel = {
        let label = UILabel()
        label.text = "100.2Kcal"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.clear
        
        self.addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalTo(0)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        containerView.addSubview(foodNameLabel)
        containerView.addSubview(caloryLabel)
        containerView.addSubview(deleteButton)
        
        foodNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.right.equalTo(-5)
        }
        
        caloryLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(deleteButton.snp.left).offset(-15)
        }
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
