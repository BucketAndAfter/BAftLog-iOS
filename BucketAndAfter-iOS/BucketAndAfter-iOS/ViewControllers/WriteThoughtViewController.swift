//
//  WriteThoughtViewController.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 10/26/26.
//

import UIKit
import SnapKit
import Then
import SwiftData

final class WriteThoughtViewController : UIViewController {
    var bucketInfo : [BucketInfo] = []
    var context = Container.mainContext
    var i : Int = 0
    
    let scrollView = UIScrollView()
    let navBar = NavigationBarView()
    
    let nameT = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
    }
    let moreT = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    let thoughtTextField = LongInputView(placeholderT: "여기에 달성 이후의 소감을 작성하세요")
    let submitButton : ButtonView = ButtonView(text: "확인")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        submitButton.buttonTapped = {
            let item = self.bucketInfo[self.i]
            let wasDone = item.isDone
            item.isDone = true
            item.thoughts = self.thoughtTextField.textField.text
            if !wasDone {
                let now = Date()
                let today = Calendar.current.dateComponents([.year, .month, .day], from: now)
                if let year = today.year, let month = today.month, let day = today.day {
                    item.date = String(format: "%4d.%2d.%2d", year, month, day)
                    print(item.date)
                }
            }
            do {
                try self.context.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("소감 작성 저장 실패")
            }
            
        }
    }
    private func setupLayout() {
        view.addSubview(scrollView)
        
        [nameT, moreT, thoughtTextField, submitButton].forEach {
            scrollView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        nameT.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(16)
        }
        moreT.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameT)
            $0.top.equalTo(nameT.snp.bottom).offset(16)
        }
        thoughtTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(scrollView.frameLayoutGuide)
            $0.top.equalTo(moreT.snp.bottom).offset(16)
        }
        submitButton.snp.makeConstraints {
            $0.top.equalTo(thoughtTextField.snp.bottom).offset(16)
            $0.trailing.equalTo(scrollView.frameLayoutGuide).inset(16)
        }
    }
    func setupTexts(i : Int) {
        self.i = i
        do {
            let descriptor = FetchDescriptor<BucketInfo>()
            bucketInfo = try context.fetch(descriptor)
            let data = bucketInfo[i]
            nameT.text = data.name
            moreT.text = data.moreInfo
            thoughtTextField.textField.text = data.thoughts
        } catch {
            print("소감작성페이지 텍스트 설정 실패 \nerror: \(error)")
        }
    }
}
