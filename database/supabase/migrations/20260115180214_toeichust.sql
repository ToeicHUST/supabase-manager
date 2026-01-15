create table public.admin_whitelist (
  email text primary key
);

-- Thêm email của bạn vào danh sách
insert into public.admin_whitelist (email) 
values
    ('vuvannghia.4522@gmail.com'),
    ('vuvannghia.work@gmail.com');

-- Bật RLS để bảo vệ bảng này (chỉ service_role mới đọc được, tránh user thường nhìn thấy)
alter table public.admin_whitelist enable row level security;

-- 1. Tạo hàm xử lý việc gán role
create or replace function public.handle_new_user_role()
returns trigger as $$
declare
  is_admin boolean;
begin
  -- Kiểm tra xem email đăng ký có nằm trong bảng whitelist không
  select exists(select 1 from public.admin_whitelist where email = new.email) into is_admin;

  if is_admin then
    new.raw_app_meta_data = 
      jsonb_set(coalesce(new.raw_app_meta_data, '{}'::jsonb), '{role}', '"admin"');
  else
    new.raw_app_meta_data = 
      jsonb_set(coalesce(new.raw_app_meta_data, '{}'::jsonb), '{role}', '"user"');
  end if;
  
  return new;
end;
$$ language plpgsql security definer;

-- 2. Gán trigger vào bảng auth.users
-- Lưu ý: Dùng BEFORE INSERT để sửa data trước khi ghi xuống
create trigger on_auth_user_created_add_role
  before insert on auth.users
  for each row execute procedure public.handle_new_user_role();