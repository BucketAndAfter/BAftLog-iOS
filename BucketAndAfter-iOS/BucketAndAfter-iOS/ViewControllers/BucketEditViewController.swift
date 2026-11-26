//
//  BucketEditViewController.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 10/26/26.
//

import UIKit
import SnapKit
import Then
import SwiftData

final class BucketEditViewController : UIViewController {
    let context = Container.mainContext
    var bucketInfo : [BucketInfo] = []
    let navBar = NavigationBarView()
    let nameTextField : TitleInputView = TitleInputView()
    let moreTextField : LongInputView = LongInputView(placeholderT: "여기에 세부사항을 입력하세요.")
    let submitButton : ButtonView = ButtonView(text: "확인")
    var i = 0
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupLayout()
        
        submitButton.buttonTapped = {
            let nameTF = self.nameTextField.textField
            let moreTF = self.moreTextField.textField
            if (nameTF.text?.isEmpty ?? true || moreTF.text?.isEmpty ?? true) {
                nameTF.layer.borderColor = UIColor.systemRed.cgColor
                nameTF.layer.borderWidth = 1
                moreTF.layer.borderColor = UIColor.systemRed.cgColor
                moreTF.layer.borderWidth = 1
            } else {
                do {
                    let discriptor = FetchDescriptor<BucketInfo>()
                    self.bucketInfo = try self.context.fetch(discriptor)
                    let item = self.bucketInfo[self.i]
                    
                    item.moreInfo = self.moreTextField.textField.text!
                    item.name = self.nameTextField.textField.text!
                    self.navigationController?.popViewController(animated: true)
                }
                catch {
                    print("수정 실패ㅜㅜ")
                }
            }
        }
    }
    private func setupLayout() {
        view.addSubview(nameTextField)
        view.addSubview(moreTextField)
        view.addSubview(submitButton)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.trailing.equalToSuperview()
        }
        moreTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameTextField.snp.bottom).offset(16)
        }
        submitButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(moreTextField.snp.bottom).offset(16)
        }
    }
    func setupText(title : String, more : String, i : Int) {
        self.nameTextField.textField.text = title
        self.moreTextField.textField.text = more
        self.i = i
    }
}
