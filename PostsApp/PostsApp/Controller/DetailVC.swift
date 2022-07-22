//
//  DetailVC.swift
//  PostsApp
//
//  Created by Андрей on 22.07.2022.
//

import UIKit

class DetailVC: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var postImageView: UIImageView = {
        let image = UIImage(named: "image")
        var postImageView = UIImageView(image: image)
        postImageView.contentMode = .scaleAspectFit
        return postImageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Ingenious Prank Music Legend Mozart Played On Someone He Couldn’t Stand"
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sometimes, it takes a little readjustment before a musician finds their feet in a group.\n\nIn this list, we will look at four musicians who have had to switch roles in the bands they were in. Whether it be due to personal preference or outside factors, these artists originally entered their groups with a role very different from what they are known best for today.\n\nWithout further ado, let’s begin!\n\n4. Paul McCartney: Guitar to Bass\n\nInitially reluctant to take over as the bassist for The Beatles, Paul McCartney grew into his role. He later became renowned as a talented multi instrumentalist.\n\n3. Joey Ramone: Drums to Vocals\n\nInitially the drummer for The Ramones, Joey Ramone replaced bassist Dee Dee Ramone as the band’s lead vocalist. As he could not play drums and sing at the same time, he gave up the role of drummer to Tommy Ramone and focused soley on being the band’s main voice.\n\n2. Roger Daltrey: Guitar to Vocals\n\nOne of the most legendary musical front-men, Roger Daltrey was originally meant to be a lead guitarist. When he took charge of the mic however, he also let go of his leadership of The Who. That decision made both him and his band’s icons of music.\n\n1. Phil Collins: Drums to Vocals\n\nInitially a drummer, Phil Collins found himself elevated to the lead singer of Genesis in the wake of Peter Gabriel’s departure. This not only kept Genesis on it’s feet but also allowed Collins to embark on a legendary solo career as a singer."
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    var likeImage: UIImageView = {
        let image = UIImage(named: "like.png")
        var likeImage = UIImageView(image: image)
        likeImage.contentMode = .scaleAspectFit
        return likeImage
    }()
    
    var likesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1957"
        label.font = UIFont(name: "Avenir Medium", size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    var dateOfPublicationLabel: UILabel = {
        let label = UILabel()
        label.text = "21 days ago"
        label.font = UIFont(name: "Avenir Medium", size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContentView()
        setScrollView()
        setCinstraints()
        
    }
    
    func setContentView() {
        let height = postImageView.frame.size.height + titleLabel.frame.size.height + subtitleLabel.frame.size.height + likeImage.frame.size.height + 80
        
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: height)
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(likeImage)
        contentView.addSubview(likesCountLabel)
        contentView.addSubview(dateOfPublicationLabel)
    }
    
    func setScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.addSubview(contentView)
        scrollView.contentSize = self.contentView.bounds.size
        self.view.addSubview(scrollView)
    }
    
    func setCinstraints() {
        [
            postImageView,
            titleLabel,
            subtitleLabel,
            likeImage,
            likesCountLabel,
            dateOfPublicationLabel
        ].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        [
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
            postImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ].forEach({$0.isActive = true})
        
        [
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ].forEach({$0.isActive = true})

        [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ].forEach({$0.isActive = true})

        [
            likeImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            likeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likeImage.widthAnchor.constraint(equalToConstant: 20),
            likeImage.heightAnchor.constraint(equalToConstant: 20)
        ].forEach({$0.isActive = true})
        
        [
            likesCountLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            likesCountLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: 5),
            likesCountLabel.heightAnchor.constraint(equalToConstant: 20),
        ].forEach({$0.isActive = true})

        [
            dateOfPublicationLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            dateOfPublicationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            likesCountLabel.heightAnchor.constraint(equalToConstant: 20)
        ].forEach({$0.isActive = true})
        
    }
  
}
