# Jenkins CI/CD Pipeline with Terraform (Activity 2)
**Name:** Aditya Ubale | **PRN:** 202301040111

- `app/` Flask app + pytest tests
- `Jenkinsfile` Checkout -> Build -> Test -> Terraform Init/Validate/Plan -> (optional) Apply
- `terraform/` AWS EC2 + security group (Infrastructure as Code)
- `jenkins/` Dockerfile + Configuration-as-Code to launch a pre-configured Jenkins
- `.github/workflows/ci-demo.yml` runs Terraform validation and a real Jenkins pipeline on GitHub's servers

Run it: GitHub -> Actions -> "Jenkins and Terraform Demo" -> Run workflow.
