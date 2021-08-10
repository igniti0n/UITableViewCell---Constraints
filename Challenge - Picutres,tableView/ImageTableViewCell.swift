//
//  ImageTableViewCell.swift
//  Challenge - Picutres,tableView
//
//  Created by Ivan Stajcer on 09.08.2021..
//

import Foundation
import UIKit

class ImageCell : UITableViewCell {
    
    lazy var label : UILabel = {
        let label = UILabel()
        return label
    }()
    let customImageView = UIImageView()


    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        doInit()
        
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doInit()
    }

    private func doInit(){



        label.text = "Moj label"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        customImageView.translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(customImageView)
        
        print(contentView)
        print("Content view width, height, height anchor")
        print(contentView.frame.width)
        print(contentView.frame.height)
        print(contentView.heightAnchor)
        print("/////////////////////////////////////////")
        
        let layoutGuideLabel = UILayoutGuide()
        addLayoutGuide(layoutGuideLabel)
        
        
            NSLayoutConstraint.activate([

                customImageView.topAnchor.constraint(equalTo: topAnchor),
                customImageView.leftAnchor.constraint(equalTo: leftAnchor),
                customImageView.rightAnchor.constraint(equalTo: rightAnchor),
                customImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.65),
                               
                layoutGuideLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                layoutGuideLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor),
                layoutGuideLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                layoutGuideLabel.bottomAnchor.constraint(equalTo: bottomAnchor),


                label.centerYAnchor.constraint(equalTo: layoutGuideLabel.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: layoutGuideLabel.centerXAnchor),


            ])
        
        
       

    }
    
  
    
}
