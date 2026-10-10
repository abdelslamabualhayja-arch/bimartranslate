# BimarTranslate — Project Requirements (MVP)

## Vision
A bilingual Arabic-first medical translation service that can later grow into a multi-translator marketplace. Initial market focus: Jordan, Gulf countries, Egypt, North Africa and the wider Arab region. Translation directions: English ↔ Arabic.

## MVP goals
1. Professional, accessible, responsive bilingual marketing site.
2. Explain the brand, services, work samples, process, FAQs, contact and preliminary legal notices.
3. Collect quote requests without file upload or automatic pricing.
4. Persist quote requests in a database when backend configuration is complete.
5. Provide a protected admin login, request list and manual status changes.
6. Support SEO foundations in both languages and deployment from GitHub.
7. Zero paid domain requirement; service free-plan limits and account/card requirements must be checked by the owner.

## Pages/sections
Home, About, Services, Quote Request, Work Samples, FAQs, Contact, Privacy/Terms summaries, Admin sign-in/dashboard.

## Quote request fields
Name, email, country, source/target direction, document type, estimated size, deadline, urgency, optional specialty and details, consent timestamp. No document upload in MVP.

## Project statuses
`new`, `reviewing`, `awaiting_approval`, `awaiting_payment`, `translating`, `review`, `ready`, `completed`, `cancelled`.

## Security requirements
- Keep public website static and do not embed secrets.
- Store request data in Supabase with RLS enabled.
- Anonymous users may insert only new quote requests; they may not select or update records.
- Only accounts whose trusted `app_metadata.role` is `admin` can list/update requests.
- No patient-document storage in MVP.
- Test unauthorized access and database policies before launch.

## Deferred
Secure file upload, client accounts/portal, translator registration, assignments, multi-translator audit log, notifications, PDF quotes/invoices, online payments, reviews, advanced analytics, certified translation service and marketplace commission model.

## Acceptance criteria before public launch
- Arabic and English page content and direction toggle checked on mobile and desktop.
- Real contact details replace placeholders.
- Supabase schema and RLS policies reviewed and tested.
- Quote request submission tested end-to-end.
- Admin authentication and role restrictions tested with admin and non-admin accounts.
- Spam/rate limiting and email notification path added.
- Privacy/terms/retention/cancellation notices legally reviewed.
- No real patient files or identifying patient data used in testing or portfolio examples.
