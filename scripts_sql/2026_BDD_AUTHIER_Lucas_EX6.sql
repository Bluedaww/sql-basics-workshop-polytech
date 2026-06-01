-- ============================================
-- Exercice 6 : Requêtes avancées sur les données existantes
-- Réalisé par : Authier Lucas
-- Date : 01/06/2026
-- ============================================

-- 1. Streamer avec au moins 1 défi
-- Affiche le pseudo du streamer et le nombre de défis auxquels il participe
SELECT streamer.pseudo, COUNT(participation_defi.id_defi) AS nombre_defis
FROM Streamer
JOIN participation_defi ON streamer.id_streamer = participation_defi.id_streamer
GROUP BY streamer.pseudo
HAVING COUNT(participation_defi.id_defi) >= 1;

-- 2. Défis avec aucun participant
-- Affiche l'intitulé du défi et le montant du palier pour les défis sans participants
SELECT intitule, montant_palier
FROM Defi
WHERE id_defi NOT IN (SELECT DISTINCT id_defi FROM participation_defi);

-- 3. Défis ayant plus de 2 participants
-- Affiche l'intitulé du défi, le montant du défi et le nombre de participants
SELECT defi.intitule, defi.montant_palier, COUNT(participation_defi.id_streamer) AS nombre_participants
FROM Defi
JOIN participation_defi ON defi.id_defi = participation_defi.id_defi
GROUP BY defi.id_defi, defi.intitule, defi.montant_palier
HAVING COUNT(participation_defi.id_streamer) > 2
ORDER BY nombre_participants DESC;

-- 4. Nombre de défis par streamer avec le montant total engagé
-- Affiche pour chaque streamer : le pseudo, le nombre de défis auxquels il participe, le montant total des paliers de ces défis par ordre décroissant
SELECT streamer.pseudo, COUNT(participation_defi.id_defi) AS nombre_defis, SUM(defi.montant_palier) AS montant_total
FROM Streamer
JOIN participation_defi ON streamer.id_streamer = participation_defi.id_streamer
JOIN Defi ON participation_defi.id_defi = defi.id_defi
GROUP BY streamer.pseudo
ORDER BY montant_total DESC;

-- 5. Streamers et créneaux avec nombre de streams effectués par créneaux
-- Affiche le pseudo du streamer, les dates du créneau et le nombre de streams réalisés dans ce créneau
SELECT streamer.pseudo, creneau.date_debut_autorisee, creneau.date_fin_autorisee, COUNT(stream.id_stream) AS nombre_streams
FROM Streamer
JOIN Creneau ON streamer.id_streamer = creneau.id_streamer
LEFT JOIN Stream ON creneau.id_creneau = stream.id_creneau
GROUP BY streamer.pseudo, creneau.date_debut_autorisee, creneau.date_fin_autorisee
ORDER BY streamer.pseudo, creneau.date_debut_autorisee;