CREATE INDEX chair_locations_chair_id_created_at_idx  ON chair_locations(chair_id, created_at);

CREATE INDEX idx_ride_statuses_ride_id_created_at ON ride_statuses(ride_id, created_at);
