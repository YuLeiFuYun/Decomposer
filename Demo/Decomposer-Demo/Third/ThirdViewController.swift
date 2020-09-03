//
//  ThirdViewController.swift
//  Decomposer-Pre
//
//  Created by 玉垒浮云 on 2020/8/29.
//

import SnapKit
import YLRefreshKit

class ThirdViewController: SViewController<ThirdViewModel, NetworkManager<ThirdModel>, CustomRefreshOperator<ThirdViewModel, NetworkManager<ThirdModel>>> {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    let ciALabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let ciBLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let commentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .brown
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        [titleLabel, authorLabel, ciALabel, ciBLabel, commentTitleLabel, commentsLabel].forEach(refreshableView!.addSubview)
        setupLayouts()
        
        refreshableView?.setAutoRefresh(refreshStateMachine: refreshStateMachine)
    }
}

extension ThirdViewController {
    func setupLayouts() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        ciALabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        ciBLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(ciALabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        commentTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ciBLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
        }
        
        commentsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(commentTitleLabel.snp.bottom).offset(-10)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
    }
}
