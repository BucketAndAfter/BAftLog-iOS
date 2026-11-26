//
//  ButtonView.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 11/4/26.
//

import UIKit
import SnapKit
import Then
final class ButtonView : UIView {
    let button = UIButton(type: .system).then {
        $0.backgroundColor = UIColor(named: "main100")
        $0.tintColor = UIColor(named: "main800")
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.layer.cornerRadius = 5
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        $0.configuration = config
    }
    var buttonTapped : (()->())?
    init(text : String) {
        super.init(frame: .zero)
        button.setTitle(text, for: .normal)
        setupLayout()
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    private func setupLayout() {
        self.addSubview(button)
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func tapped() {
        buttonTapped?()
    }
}
