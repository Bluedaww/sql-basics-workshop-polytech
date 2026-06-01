-- ============================================
-- Exercice 5 : Mise à jour et suppression
-- Réalisé par : Authier Lucas
-- Date : 01/06/2026
-- ============================================

-- Partie A : Mise à jour
-- 1. Modifier un palier en augmentant de 10% le montant du palier
UPDATE defi
SET montant_palier = montant_palier * 1.10
WHERE intitule = 'Karaoke'; 

-- 2. Valider tous les défis non validés ayant au moins 3 participants
-- On utilise une sous-requête qui compte les participants par défi dans participation_defi
-- Vérification préalable avec un SELECT
SELECT id_defi, intitule
FROM defi
WHERE etat_validation = FALSE
  AND id_defi IN (
      SELECT id_defi
      FROM participation_defi
      GROUP BY id_defi
      HAVING COUNT(id_streamer) >= 3
  );

-- Mise à jour effective
UPDATE defi
SET etat_validation = TRUE
WHERE etat_validation = FALSE
  AND id_defi IN (
      SELECT id_defi
      FROM participation_defi
      GROUP BY id_defi
      HAVING COUNT(id_streamer) >= 3
  );

-- Partie B : Suppression
-- 3. Supprimer les streams non terminés (date_fin_effective est NULL)
-- Vérification préalable
SELECT id_stream, titre, heure_debut
FROM stream
WHERE date_fin_effective IS NULL;

-- Suppression effective
DELETE FROM stream
WHERE date_fin_effective IS NULL;

-- 4. Supprimer les créneaux passés (date_fin_autorisee antérieure à aujourd'hui)
-- Vérification préalable
SELECT id_creneau, id_streamer, date_debut_autorisee, date_fin_autorisee
FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;

-- On supprime l'ancienne contrainte et on la recrée avec ON DELETE CASCADE
-- Ainsi, supprimer un créneau supprimera automatiquement les streams associés
ALTER TABLE stream DROP CONSTRAINT IF EXISTS stream_id_creneau_fkey;
ALTER TABLE stream ADD CONSTRAINT stream_id_creneau_fkey
    FOREIGN KEY (id_creneau) REFERENCES Creneau(id_creneau) ON DELETE CASCADE;

-- Suppression effective
DELETE FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;