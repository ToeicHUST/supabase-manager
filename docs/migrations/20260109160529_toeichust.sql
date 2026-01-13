-- supabase/migrations/TIMESTAMP_fix_auth_hook_permissions.sql

-- Grant quyền cho supabase_auth_admin đọc bảng user_roles
GRANT ALL ON TABLE public.user_roles TO supabase_auth_admin;

-- Revoke quyền không cần thiết
REVOKE ALL ON TABLE public.user_roles FROM authenticated, anon, public;

-- Tạo policy cho phép auth admin đọc user roles
CREATE POLICY "Allow auth admin to read user roles" 
ON public.user_roles
AS PERMISSIVE FOR SELECT
TO supabase_auth_admin
USING (true);

-- Re-create function với đầy đủ attributes như docs
DROP FUNCTION IF EXISTS public.custom_access_token_hook(jsonb);

CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
  claims jsonb;
  user_role public.user_role;  -- Dùng type thay vì text
BEGIN
  -- Fetch the user role in the user_roles table
  SELECT role INTO user_role 
  FROM public.user_roles 
  WHERE user_id = (event->>'user_id')::uuid;
  
  claims := event->'claims';
  
  IF user_role IS NOT NULL THEN
    -- Set the claim
    claims := jsonb_set(claims, '{user_role}', to_jsonb(user_role));
  ELSE
    claims := jsonb_set(claims, '{user_role}', 'null');
  END IF;
  
  -- Update the 'claims' object in the original event
  event := jsonb_set(event, '{claims}', claims);
  
  -- Return the modified event
  RETURN event;
END;
$$;

-- Grant permissions theo đúng docs
GRANT USAGE ON SCHEMA public TO supabase_auth_admin;

GRANT EXECUTE ON FUNCTION public.custom_access_token_hook TO supabase_auth_admin;

REVOKE EXECUTE ON FUNCTION public.custom_access_token_hook FROM authenticated, anon, public;