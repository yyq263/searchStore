//
//  UIImageView+DownloadImage.swift
//  searchStore
//
//  Created by Yiqin Yao on 30/10/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit
extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        // 1
        let downloadTask = session.downloadTask(with: url) { [weak self] url, response, error in
            // 2
                if error == nil, let url = url, // this url points to a local file rather than an internet address.
                    let data = try? Data(contentsOf: url), //3
                    let image = UIImage(data: data) {
                    //4
                    DispatchQueue.main.async {
                        if let strongSelf = self { // check if 'self' still exists.
                            strongSelf.image = image
                        }
                    }
            }
        }
        // 5
        downloadTask.resume()
        return downloadTask
    }
}
