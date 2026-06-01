-- ============================================
-- Exercice 2 : Requêtes SELECT simples et filtrées
-- Réalisé par : Authier Lucas
-- Date : 18/05/2026
-- ============================================

-- 1. Tous les streamers avec leur URL Twitch, ordonnés par pseudo
SELECT pseudo, url_twitch
FROM Streamer
ORDER BY pseudo;

-- 2. Les créneaux du samedi 2026-09-05
-- On utilise DATE() pour extraire uniquement la partie date du TIMESTAMP
SELECT id_creneau, id_streamer, date_debut_autorisee, date_fin_autorisee
FROM Creneau
WHERE DATE(date_debut_autorisee) = '2026-09-05';

-- 3. Les défis validés ayant un montant palier supérieur à 5000 €
SELECT id_defi, intitule, montant_palier
FROM defi
WHERE etat_validation = TRUE
  AND montant_palier > 5000;

-- 4. Les streams dont la date de fin effective est NULL (non terminés)
SELECT id_stream, id_streamer, titre, heure_debut, heure_fin
FROM stream
WHERE date_fin_effective IS NULL;
