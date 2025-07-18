//
//  ViewController.swift
//  ImageGalleryTask
//
//  Created by Aya Salman on 18/07/2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var imagesCollectionView: UICollectionView!

    var imagesArray: [String] = []
        
      
        
    
        let session: Session = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15
            configuration.timeoutIntervalForResource = 15
            return Session(configuration: configuration)
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            imagesCollectionView.delegate = self
            imagesCollectionView.dataSource = self
            
            fetchPhotos { urls in
                if let urls = urls {
                    self.imagesArray = urls
                    self.imagesCollectionView.reloadData()
                } else {
                    print("Failed to load images, using fallback...")
                    self.imagesArray = ["Gartoon-Team-Gartoon-Apps-Gtodo-todo-list.1024", "user", "icons8-weather-app-62"]
                    self.imagesCollectionView.reloadData()
                }
            }
        }
        
        func fetchPhotos(completion: @escaping ([String]?) -> Void) {
            let url = "https://picsum.photos/v2/list?page=1&limit=20"
            
            session.request(url).responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let photos):
                    let smallImages = photos.map { "https://picsum.photos/id/\($0.id)/400/400" }
                    DispatchQueue.main.async {
                        completion(smallImages)
                    }
                case .failure(let error):
                    print("Error fetching photos: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }
    }

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let urlString = imagesArray[indexPath.row]
        
        if urlString.hasPrefix("http") {
            session.request(urlString).responseData { response in
                if case .success(let data) = response.result {
                    DispatchQueue.main.async {
                        cell.imageOutlet.image = UIImage(data: data)
                    }
                }
            }
        } else {
            cell.imageOutlet.image = UIImage(named: urlString)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullVC = FullImageViewController()
        fullVC.modalPresentationStyle = .fullScreen
        
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            fullVC.selectedImage = cell.imageOutlet.image
        }
        
        present(fullVC, animated: true, completion: nil)
    }
    }
 
    


