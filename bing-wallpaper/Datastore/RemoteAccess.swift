import Foundation
import SwiftUI

enum RemoteErrors: Error {
    case invalidUrl
}

class RemoteAccess {
    // https://stackoverflow.com/questions/10639914/is-there-a-way-to-get-bings-photo-of-the-day

    private let _host = "http://www.bing.com"
    private let _location = "en-US"
    private let _queryUrl = "/HPImageArchive.aspx?format=js&idx=0&n=8&mkt="
    
    func getImageQueryUrl() -> String {
        return _host + _queryUrl + _location
    }
    func getImageUrl(meta: ImageMetaDTO) -> String {
        let imageSize = "_1920x1080.jpg"
        let imageUrl = _host + meta.urlbase + imageSize
        return imageUrl;
    }
    func getImageInfo(completed: @escaping ([ImageMetaDTO]) -> Void ) {
        guard let url = URL(string: getImageQueryUrl()) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (jsonData, _, _) in
            guard let jsonData = jsonData else { return }
            do {
                let decoder = JSONDecoder()
                let meta = try decoder.decode(ImagesMetaDTO.self, from: jsonData)
                DispatchQueue.main.async {
                    completed(meta.images)
                }
            } catch {
                DispatchQueue.main.async {
                    completed([])
                }
            }
        }
        .resume()
    }
    func getThumbnail(imageMeta: ImageMetaDTO, completed: @escaping (Result<Data, Error>) -> Void ) {
        
        let thumbsize = "_200x200.jpg"
        let thumbUrl = _host + imageMeta.urlbase + thumbsize
        let url = URL(string: thumbUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completed(.success(data))
            }
        }
        task.resume()
    }
    func getImage(imageMeta: ImageMetaDTO, completed: @escaping (Result<Data, Error>) -> Void ) {
        
        let imageUrl = self.getImageUrl(meta: imageMeta)
        let url = URL(string: imageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completed(.success(data))
            }
        }
        task.resume()
    }
}
