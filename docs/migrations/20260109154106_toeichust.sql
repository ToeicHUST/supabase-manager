-- supabase/migrations/20260109_custom_claims.sql

-- Function để thêm custom claims vào JWT
CREATE OR REPLACE FUNCTION public.custom_access_token_hook(event jsonb)
RETURNS jsonb
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
  claims jsonb;
  user_role text;
BEGIN
  -- Lấy role của user
  SELECT ur.role::text INTO user_role
  FROM public.user_roles ur
  WHERE ur.user_id = (event->>'user_id')::uuid;

  -- Nếu không tìm thấy role, set mặc định là USER
  IF user_role IS NULL THEN
    user_role := 'TOEICHUST-USER';
  END IF;

  claims := event->'claims';

  -- Thêm custom claim 'user_role' vào JWT
  claims := jsonb_set(claims, '{user_role}', to_jsonb(user_role));

  -- Cập nhật lại event với claims mới
  event := jsonb_set(event, '{claims}', claims);

  RETURN event;
END;
$$;

-- Grant quyền thực thi cho supabase_auth_admin
GRANT EXECUTE ON FUNCTION public.custom_access_token_hook TO supabase_auth_admin;

-- Revoke quyền từ public và authenticated
REVOKE EXECUTE ON FUNCTION public.custom_access_token_hook FROM authenticated, anon, public;

-- Grant usage trên schema
GRANT USAGE ON SCHEMA public TO supabase_auth_admin;