import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var interviews: UITableView!
    
    var interviewsViewModel: InterviewsViewModel = InterviewsViewModel(interviewsService: InterviewsService())

    deinit {
        print("deinit: ViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interviewsViewModel.completionBlock = { [weak self] in
            self?.interviews.reloadData()
        }
        interviewsViewModel.refreshInterviews()

    }

    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
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

