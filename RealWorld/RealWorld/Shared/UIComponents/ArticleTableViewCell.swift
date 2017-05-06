import UIKit
import Kingfisher
import SnapKit

class ArticleTableViewCell: UITableViewCell {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var article: Article? {
        didSet {
            if let article = article {
                avatar.kf.setImage(with: URL(string: (article.author?.image)!))
                authorLabel.text = article.author?.username
                if let createdAt = article.createdAt {
                    createdAtLabel.text = dateFormatter.string(from: createdAt)
                }
                titleLabel.text = article.title
                shortDescriptionLabel.text = article.descriptionValue
                readMoreLabel.text = "read more"
            }
        }
    }
    
    var avatar: UIImageView!
    var authorLabel: UILabel!
    var createdAtLabel: UILabel!
    var titleLabel: UILabel!
    var shortDescriptionLabel: UILabel!
    var readMoreLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAvatar()
        setupAuthorLabel()
        setupCreatedAtLabel()
        setupTitleLabel()
        setupShortDescriptionLabel()
        setupReadMoreLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAvatar() {
        self.avatar = UIImageView()
        self.avatar.layer.cornerRadius = 25
        self.avatar.layer.masksToBounds = true
        self.addSubview(self.avatar)
        self.avatar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.height.equalTo(50)
            make.width.equalTo(50)
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
    
    func setupTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.font = Fonts.title
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.avatar)
            make.top.equalTo(self.avatar.snp.bottom).offset(10)
        }
    }
    
    func setupShortDescriptionLabel() {
        self.shortDescriptionLabel = UILabel()
        self.shortDescriptionLabel.textColor = Colors.secondaryText
        self.shortDescriptionLabel.font = Fonts.normal
        self.addSubview(self.shortDescriptionLabel)
        self.shortDescriptionLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.avatar)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
    }
    
    func setupReadMoreLabel() {
        self.readMoreLabel = UILabel()
        self.readMoreLabel.textColor = Colors.ternaryText
        self.readMoreLabel.font = Fonts.small
        self.addSubview(self.readMoreLabel)
        self.readMoreLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.avatar)
            make.bottom.equalTo(self).offset(-20)
        }
    }
}
