<?php
class ControllerModuleRees46 extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/rees46');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');
		$this->load->model('localisation/language');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!empty($this->request->post['module'])) {
				foreach ($this->request->post['module'] as $key => $module) {
					if (!isset($module['module_id'])) {
						$module_data = $this->request->post['module'][$key];

						$module_data['module_id'] = $this->model_extension_module->addModule('rees46', $this->request->post['module'][$key]);

						$this->model_extension_module->editModule($module_data['module_id'], $module_data);
					} else {
						$this->model_extension_module->editModule($module['module_id'], $this->request->post['module'][$key]);
					}
				}
			}

			if (!empty($this->request->post['delete'])) {
				foreach ($this->request->post['delete'] as $delete) {
					$this->model_extension_module->deleteModule($delete);
				}
			}

			$this->model_setting_setting->editSetting('rees46', $this->request->post['setting']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['tab_settings'] = $this->language->get('tab_settings');
		$data['tab_modules'] = $this->language->get('tab_modules');
		$data['tab_help'] = $this->language->get('tab_help');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_tab_module'] = $this->language->get('text_tab_module');
		$data['text_documentation'] = $this->language->get('text_documentation');
		$data['text_type_interesting'] = $this->language->get('text_type_interesting');
		$data['text_type_also_bought'] = $this->language->get('text_type_also_bought');
		$data['text_type_similar'] = $this->language->get('text_type_similar');
		$data['text_type_popular'] = $this->language->get('text_type_popular');
		$data['text_type_see_also'] = $this->language->get('text_type_see_also');
		$data['text_type_recently_viewed'] = $this->language->get('text_type_recently_viewed');
		$data['text_type_buying_now'] = $this->language->get('text_type_buying_now');
		$data['text_type_search'] = $this->language->get('text_type_search');
		$data['text_template_default'] = $this->language->get('text_template_default');
		$data['text_template_basic'] = $this->language->get('text_template_basic');
		$data['text_template_bestseller'] = $this->language->get('text_template_bestseller');
		$data['text_template_featured'] = $this->language->get('text_template_featured');
		$data['text_template_latest'] = $this->language->get('text_template_latest');
		$data['text_template_special'] = $this->language->get('text_template_special');
		$data['entry_shop_id'] = $this->language->get('entry_shop_id');
		$data['entry_secret_key'] = $this->language->get('entry_secret_key');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_width'] = $this->language->get('entry_width');
		$data['entry_height'] = $this->language->get('entry_height');
		$data['entry_template'] = $this->language->get('entry_template');
		$data['entry_css'] = $this->language->get('entry_css');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/rees46', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/rees46', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/rees46', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/rees46', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['rees46_shop_id'])) {
			$data['rees46_shop_id'] = $this->request->post['rees46_shop_id'];
		} else {
			$data['rees46_shop_id'] = $this->config->get('rees46_shop_id');
		}

		if (isset($this->request->post['rees46_secret_key'])) {
			$data['rees46_secret_key'] = $this->request->post['rees46_secret_key'];
		} else {
			$data['rees46_secret_key'] = $this->config->get('rees46_secret_key');
		}

		if (isset($this->request->post['rees46_tracking_status'])) {
			$data['rees46_tracking_status'] = $this->request->post['rees46_tracking_status'];
		} else {
			$data['rees46_tracking_status'] = $this->config->get('rees46_tracking_status');
		}

		if (isset($this->request->get['module_id'])) {
			$data['module_id'] = $this->request->get['module_id'];
		}

		$data['modules'] = array();

		$modules = $this->model_extension_module->getModulesByCode('rees46');

		if (!empty($modules)) {
			foreach ($modules as $module) {
				$setting = json_decode($module['setting'], true);

				$data['modules'][] = array(
					'module_id' => $module['module_id'],
					'name'      => $module['name'],
					'setting'   => $setting
				);

				$setting = '';
			}
		}

		sort($data['modules']);

		$data['module_row'] = 1;

		if (count($data['modules']) + 1 > $data['module_row']) {
			$data['module_row'] = count($data['modules']) + 1;
		}

		$data['token'] = $this->session->data['token'];
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/rees46.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/rees46')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}