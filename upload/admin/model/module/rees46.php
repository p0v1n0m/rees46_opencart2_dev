<?php
class ModelModuleRees46 extends Model {
	public function getOrders($data = array()) {
		$sql = "SELECT o.order_id, o.customer_id, o.email, o.date_added FROM `" . DB_PREFIX . "order` o WHERE DATE(o.date_added) > DATE_SUB(NOW(), INTERVAL 6 MONTH) ORDER BY o.order_id ASC";

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getTotalOrders() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE DATE(date_added) > DATE_SUB(NOW(), INTERVAL 6 MONTH) ORDER BY order_id ASC");

		return $query->row['total'];
	}

	public function getOrderProducts($order_id) {
		$query = $this->db->query("SELECT op.product_id, op.price, op.quantity, p.quantity AS stock FROM " . DB_PREFIX . "order_product op LEFT JOIN " . DB_PREFIX . "product p ON (op.product_id = p.product_id) WHERE op.order_id = '" . (int)$order_id . "'");

		return $query->rows;
	}
}