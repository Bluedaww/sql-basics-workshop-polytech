-- ============================================
-- Exercice 3 : Requêtes SELECT avec jointures
-- Réalisé par : Authier Lucas
-- Date : 18/05/2026
-- ============================================

-- 1. Streamers et leurs créneaux
-- Affiche le pseudo du streamer et les dates de ses créneaux autorisés
-- Ordonné par pseudo puis par date de début de créneau
SELECT streamer.pseudo, creneau.date_debut_autorisee, creneau.date_fin_autorisee
FROM Streamer
JOIN Creneau ON streamer.id_streamer = creneau.id_streamer
ORDER BY streamer.pseudo, creneau.date_debut_autorisee;

-- 2. Streams avec informations du streamer et du créneau
-- Affiche le titre du stream, le pseudo du streamer et les dates du créneau associé
-- Filtré sur les streams du samedi 2026-09-05 ou du dimanche 2026-09-06
SELECT stream.titre, streamer.pseudo, creneau.date_debut_autorisee, creneau.date_fin_autorisee
FROM Stream
JOIN Streamer ON stream.id_streamer = streamer.id_streamer
JOIN Creneau ON stream.id_creneau = creneau.id_creneau
WHERE DATE(stream.heure_debut) IN ('2026-09-05', '2026-09-06')
ORDER BY stream.heure_debut;

-- 3. Défis et leurs participants
-- Affiche l'intitulé du défi, les pseudos des streamers participants et le montant du palier
-- Utilise la table de liaison participation_defi pour résoudre la relation M:N
SELECT defi.intitule, streamer.pseudo, defi.montant_palier
FROM Defi
JOIN participation_defi ON defi.id_defi = participation_defi.id_defi
JOIN Streamer ON participation_defi.id_streamer = streamer.id_streamer
ORDER BY defi.intitule, streamer.pseudo;
