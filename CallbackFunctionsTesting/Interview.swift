import Foundation
import ObjectMapper

class Interview: Mappable {
    var firstName: String?
    var lastName: String?

    required init?(map: Map) {
    }

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    func mapping(map: Map) {
        firstName <- map["first_name"]
        lastName <- map["last_name"]
    }
}
