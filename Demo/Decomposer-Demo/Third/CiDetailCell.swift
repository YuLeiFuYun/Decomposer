//
//  CiDetailCell.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/29.
//

import SnapKit

class CiDetailCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.backgroundColor = .systemPink
        label.textColor = .gray
        return label
    }()
    
    private let ciLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .systemPurple
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 消除底部横线
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        [titleLabel, authorLabel, ciLabel, commentsLabel].forEach(contentView.addSubview)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        ciLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(authorLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        commentsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ciLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(_ model: Any?) {
        guard let ciDetail = model as? CiDetail else { return }
        
        titleLabel.text = ciDetail.title
        authorLabel.text = ciDetail.author
        ciLabel.text = ciDetail.paragraphs.reduce("", { $0 + "\n" + $1 })
        
        switch ciDetail.notes.count {
        case 0:
            // 没有注释
            commentsLabel.text = ""
        default:
            let comments = ciDetail.notes.reduce("", { $0 + "\n" + $1 })
            let attrCommentsString = NSAttributedString(string: comments)
            let attribures: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.systemTeal]
            let commentsString = NSMutableAttributedString(string: "注释", attributes: attribures)
            commentsString.append(attrCommentsString)
            commentsLabel.attributedText = commentsString
        }
    }
}
