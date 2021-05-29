
import Foundation
struct MetaData : Codable {
    var creationTime : String?
    var updateTime : String?

	enum CodingKeys: String, CodingKey {

		case creationTime = "creationTime"
		case updateTime = "updateTime"
	}

	init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let displayFormat = DateFormatter()
        displayFormat.dateFormat = "dd MMM, yyyy"
        
      
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
        creationTime = try values.decodeIfPresent(String.self, forKey: .creationTime)
        updateTime = try values.decodeIfPresent(String.self, forKey: .updateTime)
        
        if let creatDate = try values.decodeIfPresent(String.self, forKey: .creationTime) {
            if let date = dateFormatter.date(from:creatDate) {
                creationTime = displayFormat.string(from: date)
            }
        }
        
        if let updateDate = try values.decodeIfPresent(String.self, forKey: .updateTime) {
            if let date = dateFormatter.date(from:updateDate) {
                updateTime = displayFormat.string(from: date)
            }
        }
        
	}

}
