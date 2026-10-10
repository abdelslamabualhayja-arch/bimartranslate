-- BimarTranslate MVP database. Run in Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.translation_requests (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  name text not null check (char_length(name) between 1 and 120),
  email text not null check (char_length(email) <= 254),
  country text not null,
  direction text not null check (direction in ('en-ar','ar-en','other')),
  document_type text not null,
  specialty text,
  size_estimate text not null,
  deadline date not null,
  urgency text not null,
  details text check (char_length(coalesce(details,'')) <= 2000),
  status text not null default 'new' check (status in ('new','reviewing','awaiting_client','awaiting_payment','in_translation','in_review','ready','completed','cancelled')),
  consent boolean not null default false
);
alter table public.translation_requests enable row level security;
revoke all on public.translation_requests from anon, authenticated;
grant insert on public.translation_requests to anon, authenticated;
grant select, update on public.translation_requests to authenticated;
drop policy if exists "public can submit quote requests" on public.translation_requests;
create policy "public can submit quote requests" on public.translation_requests for insert to anon, authenticated with check (consent = true);
drop policy if exists "admins can read requests" on public.translation_requests;
create policy "admins can read requests" on public.translation_requests for select to authenticated using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
drop policy if exists "admins can update requests" on public.translation_requests;
create policy "admins can update requests" on public.translation_requests for update to authenticated using ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin') with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
-- Note: configure CAPTCHA/rate limiting before public launch. No medical files are uploaded by this MVP.
