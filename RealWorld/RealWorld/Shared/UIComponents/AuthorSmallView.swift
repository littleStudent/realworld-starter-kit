import Foundation
import UIKit
import SnapKit

class AuthorSmallView: UIView {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var avatar: AvatarImageView!
    var authorLabel: UILabel!
    var createdAtLabel: UILabel!
    
    required init() {
        super.init(frame: .zero)
        setupAvatar()
        setupAuthorLabel()
        setupCreatedAtLabel()
    }
    
    func update(avatarUrl: String?, author: String?, createdAt: Date?) {
        if let avatarUrl = avatarUrl {
            avatar.kf.setImage(with: URL(string: avatarUrl))
        }
        if let author = author {
            authorLabel.text = author
        }
        if let createdAt = createdAt {
            createdAtLabel.text = dateFormatter.string(from: createdAt)
        }
    }
    
    func setupAvatar() {
        self.avatar = AvatarImageView()
        self.addSubview(self.avatar)
        self.avatar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(self)
        }
    }
    
    func setupAuthorLabel() {
        self.authorLabel = UILabel()
        self.authorLabel.textColor = Colors.primary
        self.authorLabel.font = Fonts.normal
        self.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(self.avatar)
            make.left.equalTo(self.avatar.snp.right).offset(10)
        }
    }
    
    func setupCreatedAtLabel() {
        self.createdAtLabel = UILabel()
        self.createdAtLabel.textColor = Colors.ternaryText
        self.createdAtLabel.font = Fonts.small
        self.addSubview(self.createdAtLabel)
        self.createdAtLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.authorLabel)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(5)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
