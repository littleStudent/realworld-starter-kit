//
//  AvatarImageView.swift
//  RealWorld
//
//  Created by Thomas Sattlecker on 06/05/2017.
//  Copyright © 2017 Thomas Sattlecker. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AvatarImageView: UIImageView {
    
    required init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
