import Foundation
import Alamofire
import AlamofireObjectMapper

protocol InterviewsServiceProtocol {
    func getMyInterviews(_ completion: @escaping ([Interview]) -> Void)
    func getInterviews(_ completion: @escaping ([Interview]) -> Void)
}

struct InterviewsService: InterviewsServiceProtocol {

    func getMyInterviews(_ completion: @escaping ([Interview]) -> Void) {
        Alamofire.request("http://10.134.23.127:4000/interview?user=currentUser")
            .responseArray { (response: DataResponse<[Interview]>) -> Void in
                if let _ = response.error {
                    return
                }
                completion(response.result.value!)
        }

    }

    func getInterviews(_ completion: @escaping ([Interview]) -> Void) {
        Alamofire.request("http://10.134.23.127:4000/interview")
            .responseArray { (response: DataResponse<[Interview]>) -> Void in
                if let _ = response.error {
                    return
                }
                completion(response.result.value!)
        }

    }
}
