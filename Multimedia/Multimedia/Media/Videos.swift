//
//  Videos.swift
//  Multimedia
//
//  Created by Kr Qqq on 11.10.2023.
//

import Foundation

struct Video {
    let url: String
    let fullName: String
}

extension Video {
    static func make() -> [Video] {
        var videosArray: [Video] = []
        
        videosArray.append(Video(url: "https://www.youtube.com/watch?v=h6cLkRoOZow", fullName: "Путешествие за пределы Плутона"))
        videosArray.append(Video(url: "https://www.youtube.com/watch?v=603FPb1ZpxM", fullName: "Путешествие к таинственным Экзопланетам"))
        videosArray.append(Video(url: "https://www.youtube.com/watch?v=H6obf1vkkz0", fullName: "Жизнь во Вселенной. Путешествие в глубокий Космос."))
        videosArray.append(Video(url: "https://www.youtube.com/watch?v=1Qs5-3YeHGk", fullName: "ПУТЕШЕСТВИЕ В НЕДРА ЗЕМЛИ"))
        videosArray.append(Video(url: "https://www.youtube.com/watch?v=WfLnyjPNl1s", fullName: "Доисторическая Земля. Путешествие в прошлое"))
        
        return videosArray
    }
}
