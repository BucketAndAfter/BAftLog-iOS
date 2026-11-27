//
//  Photos.swift
//  BucketAndAfter-iOS
//
//  Created by Seoyun Jin on 11/25/26.
//

import UIKit
import Then
import SnapKit

final class Photos : UIView {
    let button = UIButton().then {
        $0.backgroundColor = UIColor(named: "main100")
        $0.tintColor = UIColor(named: "main800")
        $0.layer.cornerRadius = 24
        $0.setImage(UIImage(systemName: "camera.fill"), for: .normal)
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        self.addSubview(button)
    
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
