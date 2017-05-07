//
//  ArticleHeaderView.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 06/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit



class ArticleHeaderView: UIView {
    
    var authorSmallView: AuthorSmallView!
    
    required init() {
        super.init(frame: .zero)
        setupAuthorSmallView()
    }
    
    func update(avatarUrl: String, username: String, createdAt: Date) {
        authorSmallView.update(avatarUrl: avatarUrl, author: username, createdAt: createdAt)
    }
    
    func setupAuthorSmallView() {
        self.authorSmallView = AuthorSmallView()
        self.addSubview(self.authorSmallView)
        self.authorSmallView.snp.makeConstraints { make -> Void in
            make.height.equalTo(70)
            make.left.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
