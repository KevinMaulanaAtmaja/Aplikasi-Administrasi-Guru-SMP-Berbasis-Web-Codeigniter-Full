<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-info sidebar sidebar-dark accordion" id="accordionSidebar">

	<!-- Sidebar - Brand -->
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="javascript:;">
		<div class="sidebar-brand-icon rotate-n-15">
			<img src="<?= base_url('assets/img/logo.png'); ?>" width="56px">
		</div>
		<div class="sidebar-brand-text mx-3">SMPN 1 Inpres</div>
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider">


	<!-- QUERY MENU -->
	<?php
	$role_id = $this->session->userdata('role_id');

	$queryMenu = "SELECT `user_menu`.`id`, `menu`
                        FROM `user_menu` JOIN `user_access_menu`
                          ON `user_menu`.`id` = `user_access_menu`.`menu_id`
                        WHERE `user_access_menu`.`role_id` = $role_id
                        ORDER BY `user_menu`.`urutan` ASC
                    ";
	$menu = $this->db->query($queryMenu)->result_array();

	?>


	<!-- LOOPING MENU -->
	<?php foreach ($menu as $m) : ?>
		<!-- Heading -->
		<div class="sidebar-heading">
			<?= $m['menu'] ?>
		</div>

		<!-- SIAPKAN SUB MENU SESUAI MENU -->
		<?php
		$menuId = $m['id'];

		$querySubMenu = "SELECT * 
                            FROM `user_sub_menu` JOIN `user_menu`
                            ON `user_sub_menu`.`menu_id` = `user_menu`.`id`
                            WHERE `user_sub_menu`.`menu_id` = $menuId
                            AND `user_sub_menu`.`is_active` = 1
                            ";
		$subMenu = $this->db->query($querySubMenu)->result_array();
		?>

		<!-- LOOPING SUB MENU -->
		<?php foreach ($subMenu as $sm) : ?>
			<li class="nav-item <?= ($title == $sm['title']) ? 'active' : ''; ?>">
				<!-- Nav Item - Dashboard -->
				<a class="nav-link pb-0" href="<?= base_url($sm['url']); ?>">
					<i class="<?= $sm['icon']; ?>"></i>
					<span><?= $sm['title']; ?></span></a>
			</li>
		<?php endforeach; ?>
		<!-- END OF LOOPING SUB MENU -->

		<!-- Divider -->
		<hr class="sidebar-divider mt-3">

	<?php endforeach; ?>
	<!-- END OF LOOPING MENU -->

	<li class="nav-item">
		<a class="nav-link pb-0" href="<?= base_url('auth/logout'); ?>">
			<i class="fas fa-fw fa-sign-out-alt"></i>
			<span>Logout</span></a>
	</li>

	<!-- Divider -->
	<hr class="sidebar-divider d-none d-md-block mt-3">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>

</ul>
<!-- End of Sidebar -->