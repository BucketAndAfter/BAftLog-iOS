//
//  BucketEditViewController.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 10/26/26.
//

import UIKit
import SnapKit
import Then

final class BucketEditViewController : UIViewController {
    let navBar = NavigationBarView()
    let titleTextField : TitleInputView = TitleInputView()
    let moreTextField : LongInputView = LongInputView(placeholderT: "여기에 세부사항을 입력하세요.")
    let submitButton : ButtonView = ButtonView(text: "확인")
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupLayout()
    }
    private func setupLayout() {
        view.addSubview(titleTextField)
        view.addSubview(moreTextField)
        view.addSubview(submitButton)
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        moreTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleTextField.snp.bottom).offset(16)
        }
        submitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(moreTextField.snp.bottom).offset(16)
        }
    }
}
