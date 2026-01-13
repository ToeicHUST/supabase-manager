resource "supabase_project" "main" {
  organization_id   = var.organization_id
  name              = var.project_name
  database_password = var.db_password
  region            = var.region

  lifecycle {
    ignore_changes = [database_password]
  }
}
data "supabase_apikeys" "main" {
  project_ref = supabase_project.main.id
}
data "supabase_pooler" "production" {
  project_ref = supabase_project.main.id
}
