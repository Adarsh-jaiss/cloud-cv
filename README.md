# cloud-cv

 A cloud-based resume service which utilises Firestore for data storage, a Google Cloud Function for fetching resume data by ID, and Terraform for infrastructure deployment.

#### prerequisites
- GCP account
```
Create a Google Cloud Service Account Key:

- Go to the Google Cloud Console.
- Navigate to IAM & Admin > Service Accounts.
- Create a new service account or use an existing one.
- Generate a new JSON key for this service account and download the file.
```

- teraform (on your local machine)
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform

```

# Getting started :

- create a collection in firestore named resumes and add json data in value field in it.
- clone the repo and run these commands to deploy the codebase on google cloud functions

```bash
pip install -r requirements.txt

gcloud auth login

terraform init

terraform validate

terraform plan

terraform apply



```

