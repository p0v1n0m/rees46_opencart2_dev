<div id="rees46-recommended-<?php echo $module_id; ?>"></div>
<script type="text/javascript"><!--
r46('recommend', '<?php echo $type; ?>', <?php echo $params; ?>, function(results) {
  if (results.length > 0) {
  	$('#rees46-recommended-<?php echo $module_id; ?>').load('index.php?route=module/rees46/getProducts&module_id=<?php echo $module_id; ?>&product_ids=' + results);
  }
});
--></script>