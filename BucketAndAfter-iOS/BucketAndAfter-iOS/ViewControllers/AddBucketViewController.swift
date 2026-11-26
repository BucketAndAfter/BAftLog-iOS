//
//  AddBucketVierController.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 10/26/26.
//

import UIKit
import SnapKit
import Then
import SwiftData

final class AddBucketViewController : UIViewController {
    let context = ModelContext(Container)
    
    let navBar = NavigationBarView()
    
    let nameTextField : TitleInputView = TitleInputView()
    let moreTextField : LongInputView = LongInputView(placeholderT: "여기에 세부사항을 입력 해 주세요")
    let submitButton:ButtonView = ButtonView(text: "확인")
    let errorLabel = UILabel().then {
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.text = "모든 필드를 채워주세요"
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setupLayout()
        submitButton.buttonTapped = {
            self.submit()
        }
    }  
    private func setupLayout() {
        view.addSubview(navBar)
        view.addSubview(nameTextField)
        view.addSubview(moreTextField)
        view.addSubview(submitButton)
        view.addSubview(errorLabel)
        
        navBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navBar.snp.bottom).offset(16)
        }
        moreTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(24)
        }
        submitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(moreTextField.snp.bottom).offset(24)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(submitButton)
            $0.leading.equalToSuperview().inset(16)
        }
    }
    private func submit() {
        if nameTextField.textField.text!.isEmpty || moreTextField.textField.text.isEmpty {
            nameTextField.textField.layer.borderColor = UIColor.red.cgColor
            nameTextField.textField.layer.borderWidth = 1
            moreTextField.textField.layer.borderColor = UIColor.red.cgColor
            moreTextField.textField.layer.borderWidth = 1
            errorLabel.isHidden = false
        } else {
            let new = BucketInfo(isDone: false, name: nameTextField.textField.text!, moreInfo: moreTextField.textField.text!, thoughts: "", date: nil)
            context.insert(new)
            do {
                try context.save()
                navigationController?.popViewController(animated: true)
            } catch {
                print("버킷 저장 실패: \(error)")
            }
            errorLabel.isHidden = true
        }
    }
}
