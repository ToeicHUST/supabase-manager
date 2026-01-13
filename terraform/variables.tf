variable "supabase_access_token" {
  description = "Supabase Access Token (lấy tại https://supabase.com/dashboard/account/tokens)"
  type        = string
  sensitive   = true
}

variable "organization_id" {
  description = "Supabase Organization ID (lấy trên URL dashboard hoặc settings)"
  type        = string
}

variable "db_password" {
  description = "Password cho Database (phải mạnh, không chứa ký tự đặc biệt gây lỗi URL)"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Tên dự án Supabase mới"
  type        = string
  default     = "Terraform Supabase Project"
}

variable "region" {
  description = "Region server (ví dụ: ap-southeast-1 là Singapore)"
  type        = string
  default     = "ap-southeast-1"
}
