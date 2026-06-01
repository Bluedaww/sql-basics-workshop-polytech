-- ============================================
-- Exercice 7 : Gestion des validations avec CASE et contraintes
-- Réalisé par : Authier Lucas
-- Date : 01/06/2026
-- ============================================

-- Partie A : Validation des streams contre les créneaux
-- 1. Affiche pour chaque stream : le titre, le pseudo du streamer, les dates du créneau autorisé, les heures réelles du stream 
-- et un statut valide ou invalide en utilisant CASE
SELECT 
    stream.titre, 
    streamer.pseudo, 
    creneau.date_debut_autorisee, 
    creneau.date_fin_autorisee, 
    stream.heure_debut, 
    stream.heure_fin,
    CASE 
        WHEN stream.heure_debut >= creneau.date_debut_autorisee 
             AND stream.heure_fin <= creneau.date_fin_autorisee THEN 'Valide'
        ELSE 'Invalide'
    END AS statut_validation
FROM Stream
JOIN Streamer ON stream.id_streamer = streamer.id_streamer
JOIN Creneau ON stream.id_creneau = creneau.id_creneau
ORDER BY stream.heure_debut;

-- 2. Requête pour trouver les streams invalides
SELECT 
    stream.titre, 
    streamer.pseudo, 
    creneau.date_debut_autorisee, 
    creneau.date_fin_autorisee, 
    stream.heure_debut, 
    stream.heure_fin
FROM Stream
JOIN Streamer ON stream.id_streamer = streamer.id_streamer
JOIN Creneau ON stream.id_creneau = creneau.id_creneau
WHERE stream.heure_debut < creneau.date_debut_autorisee 
   OR stream.heure_fin > creneau.date_fin_autorisee
ORDER BY stream.heure_debut;


-- Partie B : Détection des dépassements de fin
-- 3. Statut OK / DEPASSEMENT basé sur date_fin_effective vs heure_fin
-- Affiche le titre, le pseudo, l'heure de fin prévue, la date de fin effective,
-- un statut OK ou DEPASSEMENT, et la durée du dépassement en minutes si applicable
SELECT
    stream.titre,
    streamer.pseudo,
    stream.heure_fin,
    stream.date_fin_effective,
    CASE
        WHEN stream.date_fin_effective IS NULL THEN 'OK'
        WHEN stream.date_fin_effective <= stream.heure_fin THEN 'OK'
        ELSE 'DEPASSEMENT'
    END AS statut,
    CASE
        WHEN stream.date_fin_effective > stream.heure_fin
        THEN ROUND(CAST(EXTRACT(EPOCH FROM (stream.date_fin_effective - stream.heure_fin)) / 60 AS NUMERIC), 0)
        ELSE NULL
    END AS depassement_minutes
FROM stream
JOIN Streamer ON stream.id_streamer = streamer.id_streamer
ORDER BY stream.heure_fin;

-- 4. Résumé
-- Affiche le nombre de streams en retard et la durée moyenne de retard
SELECT
    COUNT(*) AS nombre_streams_en_retard,
    AVG(CASE
            WHEN stream.date_fin_effective > stream.heure_fin
            THEN EXTRACT(EPOCH FROM (stream.date_fin_effective - stream.heure_fin)) / 60
            ELSE NULL
        END) AS duree_moyenne_retard_minutes
FROM stream
WHERE stream.date_fin_effective > stream.heure_fin;

-- Requête combiné de 3 et 4
SELECT
    stream.titre,
    streamer.pseudo,
    stream.heure_fin,
    stream.date_fin_effective,
    CASE
        WHEN stream.date_fin_effective IS NULL THEN 'OK'
        WHEN stream.date_fin_effective <= stream.heure_fin THEN 'OK'
        ELSE 'DEPASSEMENT'
    END AS statut,
    CASE
        WHEN stream.date_fin_effective > stream.heure_fin
        THEN ROUND(CAST(EXTRACT(EPOCH FROM (stream.date_fin_effective - stream.heure_fin)) / 60 AS NUMERIC), 0)
        ELSE NULL
    END AS depassement_minutes,
    COUNT(*) OVER () AS nombre_streams_en_retard,
    AVG(CASE
            WHEN stream.date_fin_effective > stream.heure_fin
            THEN EXTRACT(EPOCH FROM (stream.date_fin_effective - stream.heure_fin)) / 60
            ELSE NULL
        END) OVER () AS duree_moyenne_retard_minutes
FROM stream
JOIN Streamer ON stream.id_streamer = streamer.id_streamer
ORDER BY stream.heure_fin;
