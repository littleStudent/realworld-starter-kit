import UIKit
import Kingfisher
import SnapKit

class ArticleTableViewCell: UITableViewCell {
    
    var article: Article? {
        didSet {
            if let article = article {
                if let avatarUrl = article.author?.image, let username = article.author?.username, let createdAt = article.createdAt {
                    authorSmallView.update(avatarUrl: avatarUrl, author: username, createdAt: createdAt)
                }
                titleLabel.text = article.title
                shortDescriptionLabel.text = article.descriptionValue
                readMoreLabel.text = "read more"
            }
        }
    }
    
    var authorSmallView: AuthorSmallView!
    var titleLabel: UILabel!
    var shortDescriptionLabel: UILabel!
    var readMoreLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAuthorSmallView()
        setupTitleLabel()
        setupShortDescriptionLabel()
        setupReadMoreLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAuthorSmallView() {
        self.authorSmallView = AuthorSmallView()
        self.addSubview(self.authorSmallView)
        self.authorSmallView.snp.makeConstraints { make -> Void in
            make.height.equalTo(70)
            make.left.equalTo(20)
        }
    }
    
    func setupTitleLabel() {
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.font = Fonts.title
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.authorSmallView)
            make.top.equalTo(self.authorSmallView.snp.bottom).offset(10)
        }
    }
    
    func setupShortDescriptionLabel() {
        self.shortDescriptionLabel = UILabel()
        self.shortDescriptionLabel.textColor = Colors.secondaryText
        self.shortDescriptionLabel.font = Fonts.normal
        self.addSubview(self.shortDescriptionLabel)
        self.shortDescriptionLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.authorSmallView)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
    }
    
    func setupReadMoreLabel() {
        self.readMoreLabel = UILabel()
        self.readMoreLabel.textColor = Colors.ternaryText
        self.readMoreLabel.font = Fonts.small
        self.addSubview(self.readMoreLabel)
        self.readMoreLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(self.authorSmallView)
            make.bottom.equalTo(self).offset(-20)
        }
    }
}
