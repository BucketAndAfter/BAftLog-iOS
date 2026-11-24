//
//  ListView.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 10/26/26.
//

import UIKit
import Then
import SnapKit

final class ListView : UIView {
    var numberInt = 0
    
    let card = UIButton().then {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = UIColor(named: "gray100")
        $0.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
    }
    let number = UILabel().then {
        $0.textColor = UIColor(named: "main800")
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(named: "gray600")
    }
    
    var changeView : ((Int)->Void)?
    
    init(numberI : Int, titleT : String, isDone : Bool, date : String) {
        super.init(frame: .zero)
        
        number.text = "\(numberI)"
        numberInt = numberI
        dateLabel.text = date
        dateLabel.isHidden = !isDone
        title.textColor = isDone ? UIColor(named: "gray600") : .black
        
        if isDone {
            let strikeA = NSMutableAttributedString(string: titleT)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            strikeA.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: strikeA.length))
            strikeA.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, strikeA.length))
            title.attributedText = strikeA
        } else {
            title.text = titleT
        }
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        self.addSubview(card)
        
        card.addSubview(number)
        card.addSubview(title)
        card.addSubview(dateLabel)
        
        card.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        number.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        title.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(number.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-4)
        }
        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
    @objc private func cardTapped() {
        //카드 클릭됨. 그 버킷리스트의 정보 더보기 페이지로 이동 로직 짜기
        print("리스트 카드 탭\(numberInt)")
        changeView?(numberInt)
    }
}
