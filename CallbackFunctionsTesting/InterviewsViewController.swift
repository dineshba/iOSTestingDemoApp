import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var interviews: UITableView!
    
    var interviewsViewModel: InterviewsViewModel = InterviewsViewModel(interviewsService: InterviewsService())

    override func viewDidLoad() {
        super.viewDidLoad()

        interviewsViewModel.getInterviews({self.interviews.reloadData()})
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interviewsViewModel.totalInterviews()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interviewCell")
        cell?.textLabel?.text = interviewsViewModel.interviewName(at: indexPath.row)
        return cell!
    }

}

