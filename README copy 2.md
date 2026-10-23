# PharmaLink Suite

Deux applications reliées à la même base Supabase :
- `pharmacie/` : logiciel privé à transformer en EXE Windows.
- `pharmaSearch/` : site public Vercel sans connexion.
- `supabase/010_pharmalink_suite.sql` : migration commune.

## Ordre
1. Exécuter les anciens scripts SQL déjà fournis, puis `010_pharmalink_suite.sql`.
2. Mettre la même URL Supabase et la même clé publishable/anon dans les deux `config.json`.
3. Valider une pharmacie avec `is_verified=true` pour que ses stocks apparaissent publiquement.
4. Déployer `pharmaSearch/` sur Vercel, Framework Other, sans build.
5. Sur un PC Windows de préparation, ouvrir `pharmacie/` et double-cliquer `build_windows.bat`.
6. Remettre au pharmacien le dossier `dist/PharmaLink-Pharmacie/` entier.

## Validation pharmacie de test
```sql
update public.pharmacies set is_verified=true, verification_status='verified' where license_number='VOTRE-LICENCE';
```

## Important
La clé dans config.json est publique : ne jamais utiliser service_role. L’EXE exige Internet pour dialoguer avec Supabase. Le catalogue français ne doit pas être présenté comme référentiel tunisien officiel ; prévoir un import séparé et une validation métier.


## Inscription dans l’EXE
Le logiciel affiche maintenant Se connecter / S’inscrire. Après inscription, Supabase envoie un email. `AUTH_REDIRECT_URL` dans `pharmacie/web/config.json` doit être remplacé par l’URL Vercel réelle de `confirmation.html`, par exemple `https://votre-pharmasearch.vercel.app/confirmation.html`. Ajoutez la même URL dans Supabase > Authentication > URL Configuration > Redirect URLs. Recompilez ensuite l’EXE.
