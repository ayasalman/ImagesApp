//
//  FullImageViewController.swift
//  ImageGalleryTask
//
//  Created by Aya Salman on 18/07/2025.
//

import UIKit

class FullImageViewController: UIViewController {
    @IBOutlet weak var fullImage: UIImageView!
    
    var selectedImage: UIImage?
        private let imageView = UIImageView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black
            
            imageView.frame = view.bounds
            imageView.contentMode = .scaleAspectFit
            imageView.image = selectedImage
            imageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(close))
            view.addGestureRecognizer(tap)
            
            view.addSubview(imageView)
        }
        
        @objc func close() {
            dismiss(animated: true, completion: nil)
        }
}
