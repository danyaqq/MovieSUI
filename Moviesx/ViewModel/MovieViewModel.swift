//
//  MovieViewModel.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import Foundation


class MovieViewModel: ObservableObject{
    
    @Published var trendingMovies: [Movie] = []
    @Published var trendingTV: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var discoverMovies: [Movie] = []
    @Published var searchMovie: [Movie] = []
    
    
    @Published var randomTrendingMovie: Movie? = nil
    @Published var movieURL: String = ""
    @Published var isLoad = false
    @Published var errorReceivingVideo = false
    
    init(){
        
        getMovies(with: "/3/trending/movie/day?api_key=\(Constant.api_key)") { [weak self] movies in
            DispatchQueue.main.async {
                self?.trendingMovies = movies
                self?.randomTrendingMovie = movies.randomElement()
            }
        }
        getMovies(with: "/3/trending/tv/day?api_key=\(Constant.api_key)") { [weak self] movies in
            DispatchQueue.main.async {
                self?.trendingTV = movies
            }
        }
        getMovies(with: "/3/movie/upcoming?api_key=\(Constant.api_key)&language=en-US&page=1") { [weak self] movies in
            DispatchQueue.main.async {
                self?.upcomingMovies = movies
            }
        }
        getMovies(with: "/3/movie/popular?api_key=\(Constant.api_key)&language=en-US&page=1") {[weak self]  movies in
            DispatchQueue.main.async {
                self?.popularMovies = movies
            }
        }
        getMovies(with: "/3/movie/top_rated?api_key=\(Constant.api_key)&language=en-US&page=1") {  [weak self] movies in
            DispatchQueue.main.async {
                self?.topRatedMovies = movies
            }
        }
        
    }
    
    
    
    func getMovies(with text: String, completion: @escaping(([Movie])-> Void)){
        guard let url = URL(string: "\(Constant.baseURL)\(text)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do{
                let decoder = try JSONDecoder().decode(ResultMovies.self, from: data)
                completion(decoder.results)
                print(decoder.results)
            } catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func searchMovie(with query: String, completion: @escaping(Result<[Movie], Error>)->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.api_key)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(ResultMovies.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getYouTubeMovie(with query: String, completion: @escaping(Result<VideoElement, Error>)->Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), query != "" else { return }
        
        guard let url = URL(string: "\(Constant.youtubeBaseURL)q=\(query)&key=\(Constant.youtube_api_key)") else { return }
        self.isLoad = true
        self.errorReceivingVideo = false
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoad = false
                    self.errorReceivingVideo = true
                    completion(.failure(error))
                }
                
            }
            guard let data = data else {
                return
            }
            do{
                let results = try JSONDecoder().decode(YouTubeMovieResponse.self, from: data)
                if let result = results.items.first{
                    DispatchQueue.main.async {
                        completion(.success(result))
                        self.isLoad = false
                        self.errorReceivingVideo = false
                    }
                    
                }
                
            }catch{
                DispatchQueue.main.async {
                    self.errorReceivingVideo = true
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
}
