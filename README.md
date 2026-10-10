# BimarTranslate

Bilingual Arabic/English medical-translation website starter, designed for static hosting and a separate Supabase backend.

## What's included

- Responsive landing page with Arabic RTL and English LTR switching.
- Services, about, illustrative portfolio samples, process, quote form, FAQs, contact section, and preliminary privacy/service notices.
- Admin sign-in page and request list/status updates.
- Supabase schema with Row Level Security (RLS).
- No file uploads in this initial release.

## Important status before launch

The site is a front-end starter until Supabase is configured. The quote form intentionally does **not** pretend to send or save requests while the configuration is missing. The admin page is unavailable until Supabase and the admin role are configured. Email notifications are not wired yet. The legal copy is preliminary and needs jurisdiction-specific review. Do not accept real patient documents until a separately reviewed secure file workflow is implemented.

## 1. Create your GitHub repository

1. Sign in to your own GitHub account.
2. Open https://github.com/new
3. Repository name: `bimartranslate`
4. Choose **Public** if you want GitHub Pages on the free plan without depending on private-repository Pages availability for your account. The source code will be public; never commit passwords, private patient data, service-role keys, or other secrets.
5. Select **Add a README file** (or leave it empty; either is fine) and create the repository.
6. Upload the contents of this project folder to the repository root. Keep paths such as `assets/styles.css` and `supabase/schema.sql` unchanged.

## 2. Enable GitHub Pages

1. In the repository, open **Settings → Pages**.
2. Under Build and deployment, choose **Deploy from a branch**.
3. Select branch `main` and folder `/ (root)`, then save.
4. Wait for the Pages URL shown in that screen. The site should be served over HTTPS after provisioning.

## 3. Configure Supabase

1. Create a Supabase project on a plan that meets your requirements. Review current free-plan limits, region/data residency, backups, and whether a payment card is required before relying on it for production.
2. Open **SQL Editor**, paste and run `supabase/schema.sql`.
3. Open **Project Settings → API** (labels may vary) and copy the project URL and publishable/anon key.
4. Edit `assets/config.js` and set `supabaseUrl` and `supabaseAnonKey`. The browser key is public by design; RLS is the security boundary. Never put a `service_role` key in this file.
5. Create the first administrator in **Authentication → Users** using an email/password. Confirm email if required by your Auth settings.
6. Assign the admin role through the Supabase SQL Editor, replacing the email with your admin email:

```sql
update auth.users
set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb
where email = 'YOUR_ADMIN_EMAIL';
```

7. Sign in at `/admin.html`. If you assigned the role while already signed in, sign out and back in so the new JWT contains the updated app metadata.
8. Test with a sample request and verify that an anonymous visitor can insert a request but cannot read or change requests. Verify a non-admin signed-in user cannot read or change them.

## 4. Contact details

In `assets/config.js`, replace `contactEmail` with a real email address and `whatsappNumber` with the international phone number digits only. The placeholder `.example` email and zero-number WhatsApp link must be replaced before launch.

## 5. Important production gaps

- Email notifications are not yet implemented. Add a server-side function and a verified email provider; do not put private provider keys in browser JavaScript.
- Add abuse protection/rate limiting and spam monitoring before publicly promoting the form.
- Add a detailed privacy policy, terms, cancellation/refund policy, retention schedule and data-subject request process after legal review.
- The admin audit log requested for a multi-translator future phase is not included yet.
- Client accounts, translator onboarding, client portal, payments, invoices and document upload are future phases.
- Public request form submissions are not yet rate-limited. Treat this as a test deployment until protection is added.
- The form collects contact information. Publish only after reviewing the applicable privacy obligations for the countries you serve.

## Local preview

Open `index.html` in a browser to preview the static design. For best testing, run a local static server rather than relying on `file://` behavior. The quote form will clearly tell you that the backend is not connected until `assets/config.js` is configured.
