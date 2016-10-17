<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $tab_settings; ?></a></li>
						<li><a href="#tab-modules" data-toggle="tab"><?php echo $tab_modules; ?></a></li>
						<li><a href="#tab-help" data-toggle="tab"><?php echo $tab_help; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-settings">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-shop_id"><?php echo $entry_shop_id; ?></label>
								<div class="col-sm-10">
									<input type="text" name="setting[rees46_shop_id]" value="<?php echo $rees46_shop_id; ?>" id="input-shop_id" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-secret_key"><?php echo $entry_secret_key; ?></label>
								<div class="col-sm-10">
									<input type="text" name="setting[rees46_secret_key]" value="<?php echo $rees46_secret_key; ?>" id="input-secret_key" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
								<div class="col-sm-10">
									<div class="btn-group" data-toggle="buttons">
										<?php if ($rees46_tracking_status) { ?>
										<label class="btn btn-info"><input type="radio" name="setting[rees46_tracking_status]" value="0" autocomplete="off"><?php echo $text_disabled; ?></label>
										<label class="btn btn-info active"><input type="radio" name="setting[rees46_tracking_status]" value="1" autocomplete="off" checked="checked"><?php echo $text_enabled; ?></label>
										<?php } else { ?>
										<label class="btn btn-info active"><input type="radio" name="setting[rees46_tracking_status]" value="0" autocomplete="off" checked="checked"><?php echo $text_disabled; ?></label>
										<label class="btn btn-info"><input type="radio" name="setting[rees46_tracking_status]" value="1" autocomplete="off"><?php echo $text_enabled; ?></label>
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-modules">
							<div class="row">
								<div class="col-md-2">
									<ul class="nav nav-pills nav-stacked">
										<?php foreach ($modules as $module) { ?>
										<li id="module-<?php echo $module['module_id']; ?>" class="module"><a href="#tab-module-<?php echo $module['module_id']; ?>" data-toggle="tab"><?php echo $module['setting']['name']; ?><span style="display: block; float: right;"><i class="fa fa-remove" onclick="$('#module-<?php echo $module['module_id']; ?>').remove(); $('#tab-module-<?php echo $module['module_id']; ?>').remove(); $('form').append('<input type=\'hidden\' name=\'delete[]\' value=\'<?php echo $module['module_id']; ?>\' />'); $('.nav-stacked .module:first-child a').trigger('click'); return false;"></i></span></a></li>
										<?php } ?>
										<li class="add"><a id="module-add" onclick="addModule();" style="cursor: pointer;"><?php echo $button_add; ?><span style="display: block; float: right;"><i class="fa fa-plus"></i></span></a></li>
									</ul>
								</div>
								<div class="col-md-10">
									<div class="tab-content">
										<?php foreach ($modules as $module) { ?>
										<div class="tab-pane" id="tab-module-<?php echo $module['module_id']; ?>">
											<input type="hidden" name="module[<?php echo $module['module_id']; ?>][module_id]" value="<?php echo $module['module_id']; ?>" />
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-name<?php echo $module['module_id']; ?>"><?php echo $entry_name; ?></label>
												<div class="col-sm-10">
													<input type="text" name="module[<?php echo $module['module_id']; ?>][name]" value="<?php echo $module['setting']['name']; ?>" id="input-name<?php echo $module['module_id']; ?>" class="form-control" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-type<?php echo $module['module_id']; ?>"><?php echo $entry_type; ?></label>
												<div class="col-sm-10">
													<select name="module[<?php echo $module['module_id']; ?>][type]" id="input-type<?php echo $module['module_id']; ?>" class="form-control">
														<option value="interesting" <?php if ($module['setting']['type'] == 'interesting') { ?>selected="selected"<?php } ?>><?php echo $text_type_interesting; ?></option>
														<option value="also_bought" <?php if ($module['setting']['type'] == 'also_bought') { ?>selected="selected"<?php } ?>><?php echo $text_type_also_bought; ?></option>
														<option value="similar" <?php if ($module['setting']['type'] == 'similar') { ?>selected="selected"<?php } ?>><?php echo $text_type_similar; ?></option>
														<option value="popular" <?php if ($module['setting']['type'] == 'popular') { ?>selected="selected"<?php } ?>><?php echo $text_type_popular; ?></option>
														<option value="see_also" <?php if ($module['setting']['type'] == 'see_also') { ?>selected="selected"<?php } ?>><?php echo $text_type_see_also; ?></option>
														<option value="recently_viewed" <?php if ($module['setting']['type'] == 'recently_viewed') { ?>selected="selected"<?php } ?>><?php echo $text_type_recently_viewed; ?></option>
														<option value="buying_now" <?php if ($module['setting']['type'] == 'buying_now') { ?>selected="selected"<?php } ?>><?php echo $text_type_buying_now; ?></option>
														<option value="search" <?php if ($module['setting']['type'] == 'search') { ?>selected="selected"<?php } ?>><?php echo $text_type_search; ?></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-title<?php echo $module['module_id']; ?>"><?php echo $entry_title; ?></label>
												<div class="col-sm-10">
													<?php foreach ($languages as $language) { ?>
													<div class="input-group pull-left">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> </span>
													<input type="text" name="module[<?php echo $module['module_id']; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo $module['setting']['title'][$language['language_id']]; ?>" id="input-title<?php echo $module['module_id']; ?>" class="form-control" />
													</div>
													<?php } ?>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-limit<?php echo $module['module_id']; ?>"><?php echo $entry_limit; ?></label>
												<div class="col-sm-10">
													<input type="text" name="module[<?php echo $module['module_id']; ?>][limit]" value="<?php echo $module['setting']['limit']; ?>" id="input-limit<?php echo $module['module_id']; ?>" class="form-control" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-width<?php echo $module['module_id']; ?>"><?php echo $entry_width; ?></label>
												<div class="col-sm-10">
													<input type="text" name="module[<?php echo $module['module_id']; ?>][width]" value="<?php echo $module['setting']['width']; ?>" id="input-width<?php echo $module['module_id']; ?>" class="form-control" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-height<?php echo $module['module_id']; ?>"><?php echo $entry_height; ?></label>
												<div class="col-sm-10">
													<input type="text" name="module[<?php echo $module['module_id']; ?>][height]" value="<?php echo $module['setting']['height']; ?>" id="input-height<?php echo $module['module_id']; ?>" class="form-control" />
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-template<?php echo $module['module_id']; ?>"><?php echo $entry_template; ?></label>
												<div class="col-sm-10">
													<select name="module[<?php echo $module['module_id']; ?>][template]" id="input-template<?php echo $module['module_id']; ?>" class="form-control">
														<option value="rees46_default" <?php if ($module['setting']['template'] == 'rees46_default') { ?>selected="selected"<?php } ?>><?php echo $text_template_default; ?></option>
														<option value="rees46_asic" <?php if ($module['setting']['template'] == 'rees46_basic') { ?>selected="selected"<?php } ?>><?php echo $text_template_basic; ?></option>
														<option value="bestseller" <?php if ($module['setting']['template'] == 'bestseller') { ?>selected="selected"<?php } ?>><?php echo $text_template_bestseller; ?></option>
														<option value="featured" <?php if ($module['setting']['template'] == 'featured') { ?>selected="selected"<?php } ?>><?php echo $text_template_featured; ?></option>
														<option value="latest" <?php if ($module['setting']['template'] == 'latest') { ?>selected="selected"<?php } ?>><?php echo $text_template_latest; ?></option>
														<option value="special" <?php if ($module['setting']['template'] == 'special') { ?>selected="selected"<?php } ?>><?php echo $text_template_special; ?></option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-css<?php echo $module['module_id']; ?>"><?php echo $entry_css; ?></label>
												<div class="col-sm-10">
													<div class="btn-group" data-toggle="buttons" id="input-css<?php echo $module['module_id']; ?>">
														<?php if ($module['setting']['css'] == 1) { ?>
														<label class="btn btn-info"><input type="radio" name="module[<?php echo $module['module_id']; ?>][css]" value="0" autocomplete="off"><?php echo $text_disabled; ?></label>
														<label class="btn btn-info active"><input type="radio" name="module[<?php echo $module['module_id']; ?>][css]" value="1" autocomplete="off" checked="checked"><?php echo $text_enabled; ?></label>
														<?php } else { ?>
														<label class="btn btn-info active"><input type="radio" name="module[<?php echo $module['module_id']; ?>][css]" value="0" autocomplete="off" checked="checked"><?php echo $text_disabled; ?></label>
														<label class="btn btn-info"><input type="radio" name="module[<?php echo $module['module_id']; ?>][css]" value="1" autocomplete="off"><?php echo $text_enabled; ?></label>
														<?php } ?>
													</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-2 control-label" for="input-status<?php echo $module['module_id']; ?>"><?php echo $entry_status; ?></label>
												<div class="col-sm-10">
													<div class="btn-group" data-toggle="buttons" id="input-status<?php echo $module['module_id']; ?>">
														<?php if ($module['setting']['status'] == 1) { ?>
														<label class="btn btn-info"><input type="radio" name="module[<?php echo $module['module_id']; ?>][status]" value="0" autocomplete="off"><?php echo $text_disabled; ?></label>
														<label class="btn btn-info active"><input type="radio" name="module[<?php echo $module['module_id']; ?>][status]" value="1" autocomplete="off" checked="checked"><?php echo $text_enabled; ?></label>
														<?php } else { ?>
														<label class="btn btn-info active"><input type="radio" name="module[<?php echo $module['module_id']; ?>][status]" value="0" autocomplete="off" checked="checked"><?php echo $text_disabled; ?></label>
														<label class="btn btn-info"><input type="radio" name="module[<?php echo $module['module_id']; ?>][status]" value="1" autocomplete="off"><?php echo $text_enabled; ?></label>
														<?php } ?>
													</div>
												</div>
											</div>
										</div>
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-help">
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $text_documentation; ?></label>
								<div class="col-sm-10"><a href="http://docs.rees46.com/display/R46D/OpenCart+2" target="_blank" class="btn">http://docs.rees46.com/display/R46D/OpenCart+2</a></div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
<?php if (isset($module_id)) { ?>
$('.nav-tabs li:nth-child(2) a').trigger('click');
$('#module-<?php echo $module_id; ?> a').trigger('click');
<?php } else { ?>
$('.nav-stacked .module:first-child a').trigger('click');
<?php } ?>

var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<div class="tab-pane" id="tab-module-' + module_row + '">';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-name' + module_row + '"><?php echo $entry_name; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<input type="text" name="module[' + module_row + '][name]" value="<?php echo $text_tab_module; ?> ' + module_row + '" id="input-name' + module_row + '" class="form-control" />';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-type' + module_row + '"><?php echo $entry_type; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<select name="module[' + module_row + '][type]" id="input-type' + module_row + '" class="form-control">';
	html += '				<option value="interesting"><?php echo $text_type_interesting; ?></option>';
	html += '				<option value="also_bought"><?php echo $text_type_also_bought; ?></option>';
	html += '				<option value="similar"><?php echo $text_type_similar; ?></option>';
	html += '				<option value="popular"><?php echo $text_type_popular; ?></option>';
	html += '				<option value="see_also"><?php echo $text_type_see_also; ?></option>';
	html += '				<option value="recently_viewed"><?php echo $text_type_recently_viewed; ?></option>';
	html += '				<option value="buying_now"><?php echo $text_type_buying_now; ?></option>';
	html += '				<option value="search"><?php echo $text_type_search; ?></option>';
	html += '			</select>';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-title' + module_row + '"><?php echo $entry_title; ?></label>';
	html += '		<div class="col-sm-10">';
	<?php foreach ($languages as $language) { ?>
	html += '			<div class="input-group pull-left">';
	html += '				<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> </span>';
	html += '				<input type="text" name="module[' + module_row + '][title][<?php echo $language['language_id']; ?>]" value="" id="input-title' + module_row + '" class="form-control" />';
	html += '			</div>';
	<?php } ?>
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-limit' + module_row + '"><?php echo $entry_limit; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<input type="text" name="module[' + module_row + '][limit]" value="" id="input-limit' + module_row + '" class="form-control" />';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-width' + module_row + '"><?php echo $entry_width; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<input type="text" name="module[' + module_row + '][width]" value="" id="input-width' + module_row + '" class="form-control" />';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-height' + module_row + '"><?php echo $entry_height; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<input type="text" name="module[' + module_row + '][height]" value="" id="input-height' + module_row + '" class="form-control" />';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-template' + module_row + '"><?php echo $entry_template; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<select name="module[' + module_row + '][template]" id="input-template' + module_row + '" class="form-control">';
	html += '				<option value="rees46_default"><?php echo $text_template_default; ?></option>';
	html += '				<option value="rees46_basic"><?php echo $text_template_basic; ?></option>';
	html += '				<option value="bestseller"><?php echo $text_template_bestseller; ?></option>';
	html += '				<option value="featured"><?php echo $text_template_featured; ?></option>';
	html += '				<option value="latest"><?php echo $text_template_latest; ?></option>';
	html += '				<option value="special"><?php echo $text_template_special; ?></option>';
	html += '			</select>';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-css' + module_row + '"><?php echo $entry_css; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<div class="btn-group" data-toggle="buttons" id="input-css' + module_row + '">';
	html += '				<label class="btn btn-info active"><input type="radio" name="module[' + module_row + '][css]" value="0" autocomplete="off" checked="checked"><?php echo $text_disabled; ?></label>';
	html += '				<label class="btn btn-info"><input type="radio" name="module[' + module_row + '][css]" value="1" autocomplete="off"><?php echo $text_enabled; ?></label>';
	html += '			</div>';
	html += '		</div>';
	html += '	</div>';
	html += '	<div class="form-group">';
	html += '		<label class="col-sm-2 control-label" for="input-status' + module_row + '"><?php echo $entry_status; ?></label>';
	html += '		<div class="col-sm-10">';
	html += '			<div class="btn-group" data-toggle="buttons" id="input-status' + module_row + '">';
	html += '				<label class="btn btn-info active"><input type="radio" name="module[' + module_row + '][status]" value="0" autocomplete="off" checked="checked"><?php echo $text_disabled; ?></label>';
	html += '				<label class="btn btn-info"><input type="radio" name="module[' + module_row + '][status]" value="1" autocomplete="off"><?php echo $text_enabled; ?></label>';
	html += '			</div>';
	html += '		</div>';
	html += '	</div>';
	html += '</div>';

	$('.row .tab-content').append(html);

	$('.nav-stacked .add').before('<li id="module-' + module_row + '" class="module"><a href="#tab-module-' + module_row + '" data-toggle="tab"><?php echo $text_tab_module; ?> ' + module_row + '<span style="display: block; float: right;"><i class="fa fa-remove" onclick="$(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); $(\'.nav-stacked .module:first-child a\').trigger(\'click\'); return false;"></i></span></a></li>');

	$('#module-' + module_row + ' a').trigger('click');

	module_row++;
}
//--></script>
<?php echo $footer; ?>