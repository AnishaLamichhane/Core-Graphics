//
//  DetailViewController.swift
//  first project
//
//  Created by Anisha Lamichhane on 6/11/20.
//  Copyright © 2020 Anisha Lamichhane. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
//        this line is for sharing icon of the images
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("no image shared")
            return
        }
        guard let image1 = imageView.image else {
            print("no image found!")
            return
        }
        let FromStromViewer = fromStromViewer(image1: image1)
        var shareable: [Any] = [FromStromViewer]
        if let imageText = selectedImage {
            shareable.append(imageText)
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated: true)
    }
    
    func fromStromViewer(image1: UIImage)-> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image1.size)
        let renderedImage = renderer.image { ctx in
            image1.draw(at: CGPoint(x: 0, y: 0))
           let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let atters: [NSAttributedString.Key: Any] = [
                .strokeWidth: -1.0,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .font:UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
               
            ]
            let string = "From Strom Viewer"
            let margin = 32
            let attributedString = NSAttributedString(string: string, attributes: atters)
            let textWidth = Int(image1.size.width) - (margin * 2)
            let textHeight = Int(image1.size.height) - (margin * 2)
            attributedString.draw(with: CGRect(x: 30, y: 30, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, context: nil)
            
        }
        return renderedImage
    }
}
