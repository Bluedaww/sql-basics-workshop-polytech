-- ============================================
-- Exercice 4 : Agrégations et statistiques
-- Réalisé par : Authier Lucas
-- Date : 01/06/2026
-- ============================================

-- 1. Nombre de stream par streamer
-- Affiche le pseudo du streamer et le nombre de streams qu'il a réalisés, même pour ceux qui n'ont réalisé aucun stream
SELECT streamer.pseudo, COALESCE(COUNT(stream.id_stream),0) AS nombre_streams
FROM Streamer
LEFT JOIN Stream ON streamer.id_streamer = stream.id_streamer
GROUP BY streamer.id_streamer, streamer.pseudo
ORDER BY nombre_streams DESC;

-- 2. Montant total des paliers de défis par état de validation
-- Affiche si le défi est validé ou non, et le montant total des paliers pour chaque état
SELECT etat_validation, COALESCE(MAX(montant_palier), 0) AS montant_max
FROM Defi
GROUP BY etat_validation;

-- 3. Streamers ayant au moins 2 défis
-- Affiche le pseudo et le nombre de défis pour les streamers engagés dans au minimum 2 défis
SELECT streamer.pseudo, COUNT(participation_defi.id_defi) AS nombre_defis
FROM Streamer
JOIN Participation_defi  ON streamer.id_streamer = participation_defi.id_streamer
GROUP BY streamer.id_streamer, streamer.pseudo
HAVING COUNT(participation_defi.id_defi) >= 2
ORDER BY nombre_defis DESC;

-- 4. Durée moyenne des streams (en heures)
-- Calcule la durée de chaque stream et affiche la durée moyenne globale à côté (fenêtre OVER)
SELECT
    titre,
    ROUND(CAST(EXTRACT(EPOCH FROM (heure_fin - heure_debut)) / 3600 AS NUMERIC), 2) AS duree_heures,
    ROUND(CAST(AVG(EXTRACT(EPOCH FROM (heure_fin - heure_debut)) / 3600) OVER() AS NUMERIC), 2) AS duree_moyenne
FROM stream
ORDER BY titre;

-- 5. Streamers ayant effectivement lancé au moins un stream
-- On n'affiche que les streamers avec au moins un stream réalisé ainsi que le titre et la date de début de leur stream
SELECT streamer.pseudo, stream.titre, stream.heure_debut
FROM Streamer
INNER JOIN stream ON streamer.id_streamer = stream.id_streamer
WHERE stream.heure_debut > '2026-09-06 11:00:00+01'
ORDER BY streamer.pseudo, stream.heure_debut;