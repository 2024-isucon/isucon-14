-- 1. chairs テーブルに owner_id にインデックスを追加
CREATE INDEX idx_chairs_owner_id ON chairs (owner_id);

-- 2. ride_statuses テーブルに ride_id と created_at に複合インデックスを追加
CREATE INDEX idx_ride_statuses_ride_id_created_at ON ride_statuses (ride_id, created_at);

-- 3. ride_statuses テーブルに chair_sent_at にインデックスを追加
CREATE INDEX idx_ride_statuses_chair_sent_at ON ride_statuses (chair_sent_at);

-- 4. ride_statuses テーブルに ride_id と status に複合インデックスを追加
CREATE INDEX idx_ride_statuses_ride_id_status ON ride_statuses (ride_id, status);

-- 5. chair_locations テーブルに chair_id にインデックスを追加 (位置情報のクエリに有用)
CREATE INDEX idx_chair_locations_chair_id ON chair_locations (chair_id);
