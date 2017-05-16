//
//  ArticleContentView.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 06/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit

class ArticleContentCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    
    func setupTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = Fonts.title
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(10)
            make.left.equalTo(20)
        }
    }
    
    func setupDescriptionLabel() {
        self.descriptionLabel = UILabel()
        self.descriptionLabel.font = Fonts.normal
        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(10)
        }
    }
}
