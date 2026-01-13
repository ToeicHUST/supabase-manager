terraform {
  required_providers {
    supabase = {
      source  = "supabase/supabase"
      version = "~> 1.0"
    }
  }
  cloud {
    organization = "toeichust"

    workspaces {
      name = "supabase-manager-prod"
    }
  }
}

provider "supabase" {
  access_token = var.supabase_access_token
}
