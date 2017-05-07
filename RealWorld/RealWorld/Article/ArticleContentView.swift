//
//  ArticleContentView.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 06/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit

class ArticleContentView: UIView {
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    required init() {
        super.init(frame: .zero)
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    func update(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    
    func setupTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = Fonts.title
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self)
        }
    }
    
    func setupDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.font = Fonts.normal
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(self)
        }
        self.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(self.descriptionLabel)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
