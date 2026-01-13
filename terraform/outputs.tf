output "projects" {
  value = {
    supabase_project_id       = supabase_project.main.id
    supabase_project_url      = "https://${supabase_project.main.id}.supabase.co"
    supabase_project_anon_key = data.supabase_apikeys.main.anon_key
  }
  sensitive = true
}

output "connection_string" {
  value = data.supabase_pooler.production.url["transaction"]
}


