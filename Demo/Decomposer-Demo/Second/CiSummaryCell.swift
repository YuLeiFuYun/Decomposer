//
//  CiSummaryCell.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/28.
//

import SnapKit

class CiSummaryCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(titleLabel)
        
        authorLabel.font = .systemFont(ofSize: 17)
        authorLabel.textColor = .gray
        contentView.addSubview(authorLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().inset(15)
            make.right.equalTo(authorLabel.snp.left).offset(-15)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(_ model: Any?) {
        guard let ciSummary = model as? CiSummary else { return }
        
        titleLabel.text = ciSummary.title
        authorLabel.text = ciSummary.author
    }
}
