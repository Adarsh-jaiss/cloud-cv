# Create a ZIP file for the function
data "archive_file" "cloudfunction_zip" {
    type        = "zip"
    source_dir  = "${path.module}/../function"
    output_file_mode = "0666"
    output_path = "${path.module}/../infra/function.zip"   # Replace with the desired output path for the ZIP file
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"  # You can set a default value, or leave it out to make it mandatory
}

variable "project" {
  description = "The GCP project ID"
  type        = string
}


# Cloud Storage bucket to host cloud function code
resource "google_storage_bucket" "cloudresume_function_bucket"{
    name          = "cloudresumeapi-function-bucket"
    location      = var.region
    storage_class = "REGIONAL"
}

resource "google_storage_bucket_object" "cloudfunction_zip" {
    name   = "function.zip"
    source = data.archive_file.cloudfunction_zip.output_path
    bucket = google_storage_bucket.cloudresume_function_bucket.name
}

# Cloud function to host the API and deploy the cloud function
resource "google_cloudfunctions_function" "cloudresumeapi_function" {
    name                    = "cloudresumeapi"
    runtime                 = "python39"
    entry_point             = "get_resume"
    source_archive_bucket   = google_storage_bucket.cloudresume_function_bucket.name
    source_archive_object   = google_storage_bucket_object.cloudfunction_zip.name
    max_instances           = 10
    available_memory_mb     = 128
    timeout                 = 3
    trigger_http            = true
}

# Make the function publicly executable
resource "google_cloudfunctions_function_iam_member" "public_access_function" {
    project        = var.project
    region         = var.region
    cloud_function = google_cloudfunctions_function.cloudresumeapi_function.name
    role           = "roles/cloudfunctions.invoker"
    member         = "allUsers"
}

provider "google" {
  credentials = file("auth.json")
  project     = var.project
  region      = var.region
}