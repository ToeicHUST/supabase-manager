<!-- npm install supabase --save-dev #Cài đặt -->
<!-- npx supabase init -->




<!-- !npx supabase login -->
<!-- npx supabase link --project-ref dwcgiqbvkjcbfeglvvbj -->
<!-- npx supabase db reset --linked -->

<!-- npx supabase migration repair --db-url "postgresql://aws-1-ap-southeast-1.pooler.supabase.com:5432/postgres?user=postgres.dwcgiqbvkjcbfeglvvbj&password=xxxxxxxxxxxxxx" --status reverted 20260109151704 -->

<!-- npx supabase db diff -f add_chat_feature -->

npx supabase db diff --use-migra
supabase db reset --linked # Chỉ dùng cho staging nếu cần làm mới hoàn toàn

<!-- ! -->

<!-- npx supabase functions deploy <function-name> -->
<!-- npx supabase functions serve <function-name> -->
<!-- npx supabase gen types typescript --local > ./types/supabase.ts -->
<!-- npx supabase gen types typescript --project <your-project-id> > ./types/s -->

<!-- ! -->

('public', 'public', true),
('avatars', 'avatars', true),
('images', 'images', false),
('audios', 'audios', false)
