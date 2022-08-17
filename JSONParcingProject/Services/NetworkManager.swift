//
//  NetworkManager.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 11.08.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
//    func fetch<T: Decodable>(_ type: T.Type, from url: String?, completion: @escaping(Result<T,NetworkError>) -> Void) {
//        guard let url = URL(string: url ?? "") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let type = try JSONDecoder().decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(type))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                completion(.failure(.decodingError))
//                }
//            }
//        }.resume()
//    }
    
    func fetchWord(from url: String, complition: @escaping(Result<[Word], AFError>) -> Void) {
    AF.request(url)
        .validate()
        .responseJSON { dataResponce in
            switch dataResponce.result {
            case .success(let value):
                let words = Word.getWord(from: value)
                complition(.success(words))
            case.failure(let error):
                complition(.failure(error))
            }
        }
    }
}
