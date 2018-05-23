SET @sName = 'bx_notifications';


-- PAGES & BLOCKS
INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_notifications_view', '_bx_ntfs_page_title_system_view', '_bx_ntfs_page_title_view', @sName, 5, 2147483647, 1, 'notifications-view', 'page.php?i=notifications-view', '', '', '', 0, 1, 0, 'BxNtfsPageView', 'modules/boonex/notifications/classes/BxNtfsPageView.php');

INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('bx_notifications_view', 1, @sName, '_bx_ntfs_page_block_title_view', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:14:"get_block_view";}', 0, 1, 1);

-- PAGES: add page block on dashboard
SET @iPBCellDashboard = 3;
SET @iPBOrderDashboard = 4; --(SELECT IFNULL(MAX(`order`), 0) FROM `sys_pages_blocks` WHERE `object` = 'sys_dashboard' AND `cell_id` = @iPBCellDashboard LIMIT 1);
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('sys_dashboard', @iPBCellDashboard, @sName, '_bx_ntfs_page_block_title_view', 11, 2147483644, 'service', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:14:"get_block_view";}', 0, 0, @iPBOrderDashboard);


-- MENU: module sub-menu
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_notifications_submenu', '_bx_ntfs_menu_title_submenu', 'bx_notifications_submenu', @sName, 8, 0, 1, '', '');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_notifications_submenu', @sName, '_bx_ntfs_menu_set_title_submenu', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_notifications_submenu', @sName, 'notifications-all', '_bx_ntfs_menu_item_title_system_notifications_all', '_bx_ntfs_menu_item_title_notifications_all', 'page.php?i=notifications-view', '', '', '', '', 2147483647, 1, 0, 1);

-- MENU: preview popup
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_notifications_preview', '_bx_ntfs_menu_title_preview', 'bx_notifications_preview', @sName, 20, 0, 1, 'BxNtfsMenuPreview', 'modules/boonex/notifications/classes/BxNtfsMenuPreview.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_notifications_preview', @sName, '_bx_ntfs_menu_set_title_preview', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_notifications_preview', @sName, 'more', '_bx_ntfs_menu_item_title_system_more', '_bx_ntfs_menu_item_title_more', 'page.php?i=notifications-view', '', '', '', '', 2147483647, 1, 0, 1);

-- MENU: Notifications
SET @iMIOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_menu_items` WHERE `set_name` = 'sys_account_notifications' AND `order` < 9999);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `submenu_popup`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_account_notifications', @sName, 'notifications-notifications', '_bx_ntfs_menu_item_title_system_notifications', '_bx_ntfs_menu_item_title_notifications', 'javascript:void(0)', 'bx_menu_slide(''bx_notifications_preview'', this, ''site'', {id:{value:''bx_notifications_preview'', force:1}});', '', 'bell col-green3', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:28:"get_unread_notifications_num";}', 'bx_notifications_preview', '1', 2147483646, 1, 1, @iMIOrder + 1);


-- SETTINGS
SET @iTypeOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_options_types` WHERE `group` = 'modules');
INSERT INTO `sys_options_types`(`group`, `name`, `caption`, `icon`, `order`) VALUES 
('modules', @sName, '_bx_ntfs', 'bx_notifications@modules/boonex/notifications/|std-icon.svg', @iTypeOrder + 1);
SET @iTypeId = LAST_INSERT_ID();

INSERT INTO `sys_options_categories` (`type_id`, `name`, `caption`, `order`)
VALUES (@iTypeId, @sName, '_bx_ntfs', 1);
SET @iCategId = LAST_INSERT_ID();

INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_params`, `check_error`, `extra`, `order`) VALUES
('bx_notifications_events_per_page', '12', @iCategId, '_bx_ntfs_option_events_per_page', 'digit', '', '', '', '', 1),
('bx_notifications_events_per_preview', '20', @iCategId, '_bx_ntfs_option_events_per_preview', 'digit', '', '', '', '', 5),
('bx_notifications_events_hide_site', '', @iCategId, '_bx_ntfs_option_events_hide_site', 'rlist', '', '', '', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:21:"get_actions_checklist";}', 10),
('bx_notifications_events_hide_email', '', @iCategId, '_bx_ntfs_option_events_hide_email', 'rlist', '', '', '', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:21:"get_actions_checklist";}', 11),
('bx_notifications_events_hide_push', '', @iCategId, '_bx_ntfs_option_events_hide_push', 'rlist', '', '', '', 'a:2:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:21:"get_actions_checklist";}', 12);


-- PRIVACY 
INSERT INTO `sys_objects_privacy` (`object`, `module`, `action`, `title`, `default_group`, `table`, `table_field_id`, `table_field_author`, `override_class_name`, `override_class_file`) VALUES
('bx_notifications_privacy_view', @sName, 'view', '_bx_notifications_privacy_view', '3', 'bx_notifications_events', 'id', 'owner_id', 'BxNtfsPrivacy', 'modules/boonex/notifications/classes/BxNtfsPrivacy.php');


-- LIVE UPDATES
INSERT INTO `sys_objects_live_updates`(`name`, `frequency`, `service_call`, `active`) VALUES
(@sName, 1, 'a:3:{s:6:"module";s:16:"bx_notifications";s:6:"method";s:16:"get_live_updates";s:6:"params";a:3:{i:0;a:2:{s:11:"menu_object";s:18:"sys_toolbar_member";s:9:"menu_item";s:7:"account";}i:1;a:2:{s:11:"menu_object";s:25:"sys_account_notifications";s:9:"menu_item";s:27:"notifications-notifications";}i:2;s:7:"{count}";}}', 1);


-- ALERTS
INSERT INTO `sys_alerts_handlers`(`name`, `class`, `file`, `service_call`) VALUES 
(@sName, 'BxNtfsResponse', 'modules/boonex/notifications/classes/BxNtfsResponse.php', '');
SET @iHandler := LAST_INSERT_ID();

INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('profile', 'delete', @iHandler),

('meta_mention', 'added', @iHandler),

('sys_profiles_friends', 'connection_added', @iHandler),
('sys_profiles_friends', 'connection_removed', @iHandler),

('sys_profiles_subscriptions', 'connection_added', @iHandler),
('sys_profiles_subscriptions', 'connection_removed', @iHandler);


-- EMAIL TEMPLATES
INSERT INTO `sys_email_templates` (`Module`, `NameSystem`, `Name`, `Subject`, `Body`) VALUES
(@sName, '_bx_ntfs_email_new_event', 'bx_notifications_new_event', '_bx_ntfs_email_new_event_subject', '_bx_ntfs_email_new_event_body');
