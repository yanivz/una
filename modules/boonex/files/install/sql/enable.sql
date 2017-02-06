
-- SETTINGS

SET @iTypeOrder = (SELECT MAX(`order`) FROM `sys_options_types` WHERE `group` = 'modules');
INSERT INTO `sys_options_types`(`group`, `name`, `caption`, `icon`, `order`) VALUES 
('modules', 'bx_files', '_bx_files', 'bx_files@modules/boonex/files/|std-icon.svg', IF(ISNULL(@iTypeOrder), 1, @iTypeOrder + 1));
SET @iTypeId = LAST_INSERT_ID();

INSERT INTO `sys_options_categories` (`type_id`, `name`, `caption`, `order`)
VALUES (@iTypeId, 'bx_files', '_bx_files', 1);
SET @iCategId = LAST_INSERT_ID();

INSERT INTO `sys_options` (`name`, `value`, `category_id`, `caption`, `type`, `check`, `check_error`, `extra`, `order`) VALUES
('bx_files_summary_chars', '700', @iCategId, '_bx_files_option_summary_chars', 'digit', '', '', '', 1),
('bx_files_per_page_browse', '12', @iCategId, '_bx_files_option_per_page_browse', 'digit', '', '', '', 10),
('bx_files_per_page_profile', '3', @iCategId, '_bx_files_option_per_page_profile', 'digit', '', '', '', 12),
('bx_files_rss_num', '10', @iCategId, '_bx_files_option_rss_num', 'digit', '', '', '', 20),
('bx_files_searchable_fields', 'title,desc,data', @iCategId, '_bx_files_option_searchable_fields', 'list', '', '', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:21:"get_searchable_fields";}', 30);

-- PAGE: create entry

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_create_entry', '_bx_files_page_title_sys_create_entry', '_bx_files_page_title_create_entry', 'bx_files', 5, 2147483647, 1, 'create-file', 'page.php?i=create-file', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('bx_files_create_entry', 1, 'bx_files', '_bx_files_page_block_title_create_entry', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:13:"entity_create";}', 0, 1, 1);


-- PAGE: edit entry

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_edit_entry', '_bx_files_page_title_sys_edit_entry', '_bx_files_page_title_edit_entry', 'bx_files', 5, 2147483647, 1, 'edit-file', '', '', '', '', 0, 1, 0, 'BxFilesPageEntry', 'modules/boonex/files/classes/BxFilesPageEntry.php');

INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('bx_files_edit_entry', 1, 'bx_files', '_bx_files_page_block_title_edit_entry', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:11:"entity_edit";}', 0, 0, 0);


-- PAGE: delete entry

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_delete_entry', '_bx_files_page_title_sys_delete_entry', '_bx_files_page_title_delete_entry', 'bx_files', 5, 2147483647, 1, 'delete-file', '', '', '', '', 0, 1, 0, 'BxFilesPageEntry', 'modules/boonex/files/classes/BxFilesPageEntry.php');

INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('bx_files_delete_entry', 1, 'bx_files', '_bx_files_page_block_title_delete_entry', 11, 2147483647, 'service', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:13:"entity_delete";}', 0, 0, 0);


-- PAGE: view entry

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_view_entry', '_bx_files_page_title_sys_view_entry', '_bx_files_page_title_view_entry', 'bx_files', 10, 2147483647, 1, 'view-file', '', '', '', '', 0, 1, 0, 'BxFilesPageEntry', 'modules/boonex/files/classes/BxFilesPageEntry.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_files_view_entry', 1, 'bx_files', '', '_bx_files_page_block_title_entry_text', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:17:\"entity_text_block\";}', 0, 0, 1, 1),
('bx_files_view_entry', 1, 'bx_files', '', '_bx_files_page_block_title_entry_file_preview', 3, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:19:\"entity_file_preview\";}', 0, 0, 1, 2),
('bx_files_view_entry', 2, 'bx_files', '', '_bx_files_page_block_title_entry_author', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:13:\"entity_author\";}', 0, 0, 1, 0),
('bx_files_view_entry', 3, 'bx_files', '', '_bx_files_page_block_title_entry_info', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:11:\"entity_info\";}', 0, 0, 1, 1),
('bx_files_view_entry', 3, 'bx_files', '', '_bx_files_page_block_title_entry_location', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:15:\"entity_location\";}', 0, 0, 0, 2),
('bx_files_view_entry', 4, 'bx_files', '', '_bx_files_page_block_title_entry_all_actions', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:18:\"entity_all_actions\";}', 0, 0, 1, 0),
('bx_files_view_entry', 4, 'bx_files', '', '_bx_files_page_block_title_entry_actions', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:14:\"entity_actions\";}', 0, 0, 0, 1),
('bx_files_view_entry', 4, 'bx_files', '', '_bx_files_page_block_title_entry_social_sharing', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:21:\"entity_social_sharing\";}', 0, 0, 0, 2),
('bx_files_view_entry', 4, 'bx_files', '', '_bx_files_page_block_title_entry_comments', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:15:\"entity_comments\";}', 0, 0, 1, 4),
('bx_files_view_entry', 4, 'bx_files', '', '_bx_files_page_block_title_entry_location', 3, 2147483647, 'service', 'a:4:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:13:\"locations_map\";s:6:\"params\";a:2:{i:0;s:8:\"bx_files\";i:1;s:4:\"{id}\";}s:5:\"class\";s:20:\"TemplServiceMetatags\";}', 0, 0, 1, 5);


-- PAGE: view entry comments

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_view_entry_comments', '_bx_files_page_title_sys_view_entry_comments', '_bx_files_page_title_view_entry_comments', 'bx_files', 5, 2147483647, 1, 'view-file-comments', '', '', '', '', 0, 1, 0, 'BxFilesPageEntry', 'modules/boonex/files/classes/BxFilesPageEntry.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_files_view_entry_comments', 1, 'bx_files', '_bx_files_page_block_title_entry_comments', '_bx_files_page_block_title_entry_comments_link', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:15:\"entity_comments\";}', 0, 0, 1);


-- PAGE: popular entries

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_popular', '_bx_files_page_title_sys_entries_popular', '_bx_files_page_title_entries_popular', 'bx_files', 5, 2147483647, 1, 'files-popular', 'page.php?i=files-popular', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_files_popular', 1, 'bx_files', '_bx_files_page_block_title_popular_entries', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:14:"browse_popular";s:6:"params";a:3:{s:9:"unit_view";s:7:"gallery";s:13:"empty_message";b:1;s:13:"ajax_paginate";b:0;}}', 0, 1, 1);


-- PAGE: recently updated entries

INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_updated', '_bx_files_page_title_sys_entries_updated', '_bx_files_page_title_entries_updated', 'bx_files', 5, 2147483647, 1, 'files-updated', 'page.php?i=files-updated', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_files_updated', 1, 'bx_files', '_bx_files_page_block_title_updated_entries', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:14:"browse_updated";s:6:"params";a:3:{s:9:"unit_view";s:7:"gallery";s:13:"empty_message";b:1;s:13:"ajax_paginate";b:0;}}', 0, 1, 1);


-- PAGE: entries of author

INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_author', 'files-author', '_bx_files_page_title_sys_entries_of_author', '_bx_files_page_title_entries_of_author', 'bx_files', 5, 2147483647, 1, '', '', '', '', 0, 1, 0, 'BxFilesPageAuthor', 'modules/boonex/files/classes/BxFilesPageAuthor.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_files_author', 1, 'bx_files', '', '_bx_files_page_block_title_entries_actions', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:18:\"my_entries_actions\";}', 0, 0, 1, 1),
('bx_files_author', 1, 'bx_files', '_bx_files_page_block_title_sys_favorites_of_author', '_bx_files_page_block_title_favorites_of_author', 11, 2147483647, 'service', 'a:3:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:15:\"browse_favorite\";s:6:"params";a:1:{i:0;s:12:"{profile_id}";}}', 0, 1, 1, 2),
('bx_files_author', 1, 'bx_files', '_bx_files_page_block_title_sys_entries_of_author', '_bx_files_page_block_title_entries_of_author', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:13:\"browse_author\";}', 0, 0, 1, 3);

-- PAGE: entries of group

INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_group', 'group-files', '_bx_files_page_title_sys_entries_of_author', '_bx_files_page_title_entries_of_author', 'bx_files', 5, 2147483647, 1, '', '', '', '', 0, 1, 0, 'BxFilesPageAuthor', 'modules/boonex/files/classes/BxFilesPageAuthor.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('bx_files_group', 1, 'bx_files', '', '_bx_files_page_block_title_entries_actions', 13, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:18:\"my_entries_actions\";}', 0, 0, 1, 1),
('bx_files_group', 1, 'bx_files', '_bx_files_page_block_title_sys_entries_of_author', '_bx_files_page_block_title_entries_of_author', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:19:\"browse_group_author\";}', 0, 0, 1, 3);

-- PAGE: module home

INSERT INTO `sys_objects_page`(`object`, `uri`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_home', 'files-home', '_bx_files_page_title_sys_home', '_bx_files_page_title_home', 'bx_files', 2, 2147483647, 1, 'page.php?i=files-home', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES
('bx_files_home', 1, 'bx_files', '', '_bx_files_page_block_title_featured_entries_view_extended', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:15:"browse_featured";s:6:"params";a:1:{i:0;s:8:"extended";}}', 0, 1, 1, 0),
('bx_files_home', 1, 'bx_files', '', '_bx_files_page_block_title_recent_entries_view_extended', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:13:"browse_public";s:6:"params";a:1:{i:0;s:8:"extended";}}', 0, 1, 1, 1),
('bx_files_home', 2, 'bx_files', '', '_bx_files_page_block_title_popular_keywords', 11, 2147483647, 'service', 'a:4:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:14:\"keywords_cloud\";s:6:\"params\";a:2:{i:0;s:8:\"bx_files\";i:1;s:8:\"bx_files\";}s:5:\"class\";s:20:\"TemplServiceMetatags\";}', 0, 1, 1, 0),
('bx_files_home', 2, 'bx_files', '', '_bx_files_page_block_title_cats', 11, 2147483647, 'service', 'a:4:{s:6:\"module\";s:6:\"system\";s:6:\"method\";s:15:\"categories_list\";s:6:\"params\";a:2:{i:0;s:13:\"bx_files_cats\";i:1;a:1:{s:10:\"show_empty\";b:1;}}s:5:\"class\";s:20:\"TemplServiceCategory\";}', 0, 1, 1, 1);

-- PAGE: module manage own
INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_manage', '_bx_files_page_title_sys_manage', '_bx_files_page_title_manage', 'bx_files', 5, 2147483647, 1, 'files-manage', 'page.php?i=files-manage', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_files_manage', 1, 'bx_files', '_bx_files_page_block_title_system_manage', '_bx_files_page_block_title_manage', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:12:\"manage_tools\";}}', 0, 1, 0);

-- PAGE: module manage all
INSERT INTO `sys_objects_page`(`object`, `title_system`, `title`, `module`, `layout_id`, `visible_for_levels`, `visible_for_levels_editable`, `uri`, `url`, `meta_description`, `meta_keywords`, `meta_robots`, `cache_lifetime`, `cache_editable`, `deletable`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_administration', '_bx_files_page_title_sys_manage_administration', '_bx_files_page_title_manage', 'bx_files', 5, 192, 1, 'files-administration', 'page.php?i=files-administration', '', '', '', 0, 1, 0, 'BxFilesPageBrowse', 'modules/boonex/files/classes/BxFilesPageBrowse.php');

INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title_system`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('bx_files_administration', 1, 'bx_files', '_bx_files_page_block_title_system_manage_administration', '_bx_files_page_block_title_manage', 11, 192, 'service', 'a:3:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:12:\"manage_tools\";s:6:\"params\";a:1:{i:0;s:14:\"administration\";}}', 0, 1, 0);

-- PAGE: add block to homepage

SET @iBlockOrder = (SELECT `order` FROM `sys_pages_blocks` WHERE `object` = 'sys_home' AND `cell_id` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `active`, `order`) VALUES 
('sys_home', 1, 'bx_files', '_bx_files_page_block_title_recent_entries', 11, 2147483647, 'service', 'a:2:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:13:\"browse_public\";}', 1, 0, 0, IFNULL(@iBlockOrder, 0) + 1);

-- PAGES: add page block to profiles modules (trigger* page objects are processed separately upon modules enable/disable)
SET @iPBCellProfile = 3;
SET @iPBCellGroup = 4;
INSERT INTO `sys_pages_blocks` (`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES
('trigger_page_profile_view_entry', @iPBCellProfile, 'bx_files', '_bx_files_page_block_title_my_entries', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:13:"browse_author";s:6:"params";a:2:{i:0;s:12:"{profile_id}";i:1;a:1:{s:8:"per_page";s:25:"bx_files_per_page_profile";}}}', 0, 0, 0),
('trigger_page_group_view_entry', @iPBCellGroup, 'bx_files', '_bx_files_page_block_title_group_entries', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:19:"browse_group_author";s:6:"params";a:2:{i:0;s:12:"{profile_id}";i:1;a:1:{s:8:"per_page";s:25:"bx_files_per_page_profile";}}}', 0, 0, 0);

-- PAGE: service blocks

SET @iBlockOrder = (SELECT `order` FROM `sys_pages_blocks` WHERE `object` = '' AND `cell_id` = 0 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_pages_blocks`(`object`, `cell_id`, `module`, `title`, `designbox_id`, `visible_for_levels`, `type`, `content`, `deletable`, `copyable`, `order`) VALUES 
('', 0, 'bx_files', '_bx_files_page_block_title_recent_entries', 11, 2147483647, 'service', 'a:3:{s:6:\"module\";s:8:\"bx_files\";s:6:\"method\";s:13:\"browse_public\";s:6:\"params\";a:3:{s:9:\"unit_view\";s:7:\"gallery\";s:13:\"empty_message\";b:1;s:13:\"ajax_paginate\";b:0;}}', 0, 1, IFNULL(@iBlockOrder, 0) + 1),

('', 0, 'bx_files', '_bx_files_page_block_title_popular_entries_view_extended', 11, 2147483647, 'service', 'a:3:{s:6:"module";s:8:"bx_files";s:6:"method";s:14:"browse_popular";s:6:"params";a:1:{i:0;s:8:"extended";}}', 0, 1, IFNULL(@iBlockOrder, 0) + 2);


-- MENU: add to site menu

SET @iSiteMenuOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_site' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_site', 'bx_files', 'files-home', '_bx_files_menu_item_title_system_entries_home', '_bx_files_menu_item_title_entries_home', 'page.php?i=files-home', '', '', 'file-o col-red3', 'bx_files_submenu', 2147483647, 1, 1, IFNULL(@iSiteMenuOrder, 0) + 1);

-- MENU: add to homepage menu

SET @iHomepageMenuOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_homepage' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_homepage', 'bx_files', 'files-home', '_bx_files_menu_item_title_system_entries_home', '_bx_files_menu_item_title_entries_home', 'page.php?i=files-home', '', '', 'file-o col-red3', 'bx_files_submenu', 2147483647, 1, 1, IFNULL(@iHomepageMenuOrder, 0) + 1);

-- MENU: add to "add content" menu

SET @iAddMenuOrder = (SELECT `order` FROM `sys_menu_items` WHERE `set_name` = 'sys_add_content_links' AND `active` = 1 ORDER BY `order` DESC LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_add_content_links', 'bx_files', 'create-file', '_bx_files_menu_item_title_system_create_entry', '_bx_files_menu_item_title_create_entry', 'page.php?i=create-file', '', '', 'file-o col-red3', '', 2147483647, 1, 1, IFNULL(@iAddMenuOrder, 0) + 1);


-- MENU: actions menu for view entry 

INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_view', '_bx_files_menu_title_view_entry', 'bx_files_view', 'bx_files', 9, 0, 1, 'BxFilesMenuView', 'modules/boonex/files/classes/BxFilesMenuView.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_files_view', 'bx_files', '_bx_files_menu_set_title_view_entry', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_files_view', 'bx_files', 'download-file', '_bx_files_menu_item_title_system_download_file', '_bx_files_menu_item_title_download_file', 'modules/?r=files/download/{file_download_token}/{content_id}.{file_ext}', '', '_blank', 'download', '', 2147483647, 1, 0, 1),
('bx_files_view', 'bx_files', 'edit-file', '_bx_files_menu_item_title_system_edit_entry', '_bx_files_menu_item_title_edit_entry', 'page.php?i=edit-file&id={content_id}', '', '', 'pencil', '', 2147483647, 1, 0, 2),
('bx_files_view', 'bx_files', 'delete-file', '_bx_files_menu_item_title_system_delete_entry', '_bx_files_menu_item_title_delete_entry', 'page.php?i=delete-file&id={content_id}', '', '', 'remove', '', 2147483647, 1, 0, 3);


-- MENU: actions menu for my entries

INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_my', '_bx_files_menu_title_entries_my', 'bx_files_my', 'bx_files', 9, 0, 1, 'BxFilesMenu', 'modules/boonex/files/classes/BxFilesMenu.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_files_my', 'bx_files', '_bx_files_menu_set_title_entries_my', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_files_my', 'bx_files', 'create-file', '_bx_files_menu_item_title_system_create_entry', '_bx_files_menu_item_title_create_entry', 'page.php?i=create-file&profile_id={profile_id}', '', '', 'plus', '', 2147483647, 1, 0, 0);


-- MENU: module sub-menu

INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_submenu', '_bx_files_menu_title_submenu', 'bx_files_submenu', 'bx_files', 8, 0, 1, '', '');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_files_submenu', 'bx_files', '_bx_files_menu_set_title_submenu', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_files_submenu', 'bx_files', 'files-home', '_bx_files_menu_item_title_system_entries_public', '_bx_files_menu_item_title_entries_public', 'page.php?i=files-home', '', '', '', '', 2147483647, 1, 1, 1),
('bx_files_submenu', 'bx_files', 'files-popular', '_bx_files_menu_item_title_system_entries_popular', '_bx_files_menu_item_title_entries_popular', 'page.php?i=files-popular', '', '', '', '', 2147483647, 1, 1, 2),
('bx_files_submenu', 'bx_files', 'files-manage', '_bx_files_menu_item_title_system_entries_manage', '_bx_files_menu_item_title_entries_manage', 'page.php?i=files-manage', '', '', '', '', 2147483646, 1, 1, 3);

-- MENU: sub-menu for view entry

INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_view_submenu', '_bx_files_menu_title_view_entry_submenu', 'bx_files_view_submenu', 'bx_files', 8, 0, 1, 'BxFilesMenuView', 'modules/boonex/files/classes/BxFilesMenuView.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_files_view_submenu', 'bx_files', '_bx_files_menu_set_title_view_entry_submenu', 0);

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('bx_files_view_submenu', 'bx_files', 'view-file', '_bx_files_menu_item_title_system_view_entry', '_bx_files_menu_item_title_view_entry_submenu_entry', 'page.php?i=view-file&id={content_id}', '', '', '', '', 2147483647, 0, 0, 1),
('bx_files_view_submenu', 'bx_files', 'view-file-comments', '_bx_files_menu_item_title_system_view_entry_comments', '_bx_files_menu_item_title_view_entry_submenu_comments', 'page.php?i=view-file-comments&id={content_id}', '', '', '', '', 2147483647, 0, 0, 2);

-- MENU: profile stats
SET @iNotifMenuOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_menu_items` WHERE `set_name` = 'sys_profile_stats' AND `active` = 1 LIMIT 1);
INSERT INTO `sys_menu_items` (`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES
('sys_profile_stats', 'bx_files', 'profile-stats-manage-files', '_bx_files_menu_item_title_system_manage_my_files', '_bx_files_menu_item_title_manage_my_files', 'page.php?i=files-manage', '', '_self', 'file-o col-red3', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:41:"get_menu_addon_manage_tools_profile_stats";}', '', 2147483646, 1, 0, @iNotifMenuOrder + 1);

-- MENU: manage tools submenu
INSERT INTO `sys_objects_menu`(`object`, `title`, `set_name`, `module`, `template_id`, `deletable`, `active`, `override_class_name`, `override_class_file`) VALUES 
('bx_files_menu_manage_tools', '_bx_files_menu_title_manage_tools', 'bx_files_menu_manage_tools', 'bx_files', 6, 0, 1, 'BxFilesMenuManageTools', 'modules/boonex/files/classes/BxFilesMenuManageTools.php');

INSERT INTO `sys_menu_sets`(`set_name`, `module`, `title`, `deletable`) VALUES 
('bx_files_menu_manage_tools', 'bx_files', '_bx_files_menu_set_title_manage_tools', 0);

--INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
--('bx_files_menu_manage_tools', 'bx_files', 'delete-with-content', '_bx_files_menu_item_title_system_delete_with_content', '_bx_files_menu_item_title_delete_with_content', 'javascript:void(0)', 'javascript:{js_object}.onClickDeleteWithContent({content_id});', '_self', 'trash-o', '', 128, 1, 0, 0);

-- MENU: dashboard manage tools
SET @iManageMenuOrder = (SELECT IFNULL(MAX(`order`), 0) FROM `sys_menu_items` WHERE `set_name`='sys_account_dashboard_manage_tools' LIMIT 1);
INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `addon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('sys_account_dashboard_manage_tools', 'bx_files', 'files-administration', '_bx_files_menu_item_title_system_admt_files', '_bx_files_menu_item_title_admt_files', 'page.php?i=files-administration', '', '_self', '', 'a:2:{s:6:"module";s:8:"bx_files";s:6:"method";s:27:"get_menu_addon_manage_tools";}', '', 192, 1, 0, @iManageMenuOrder + 1);

-- MENU: add menu item to profile & group based modules (trigger* menu sets are processed separately upon modules enable/disable)

INSERT INTO `sys_menu_items`(`set_name`, `module`, `name`, `title_system`, `title`, `link`, `onclick`, `target`, `icon`, `submenu_object`, `visible_for_levels`, `active`, `copyable`, `order`) VALUES 
('trigger_profile_view_submenu', 'bx_files', 'files-author', '_bx_files_menu_item_title_system_view_entries_author', '_bx_files_menu_item_title_view_entries_author', 'page.php?i=files-author&profile_id={profile_id}', '', '', 'file-o col-red3', '', 2147483647, 1, 0, 0),
('trigger_group_view_submenu', 'bx_files', 'group-files', '_bx_files_menu_item_title_system_view_entries_author', '_bx_files_menu_item_title_view_entries_author', 'page.php?i=group-files&profile_id={profile_id}', '', '', 'file-o col-red3', '', 2147483647, 1, 0, 0);


-- PRIVACY 

INSERT INTO `sys_objects_privacy` (`object`, `module`, `action`, `title`, `default_group`, `table`, `table_field_id`, `table_field_author`, `override_class_name`, `override_class_file`) VALUES
('bx_files_allow_view_to', 'bx_files', 'view', '_bx_files_form_entry_input_allow_view_to', '3', 'bx_files_main', 'id', 'author', 'BxFilesPrivacy', 'modules/boonex/files/classes/BxFilesPrivacy.php');


-- ACL

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_files', 'create entry', NULL, '_bx_files_acl_action_create_entry', '', 1, 3);
SET @iIdActionEntryCreate = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_files', 'delete entry', NULL, '_bx_files_acl_action_delete_entry', '', 1, 3);
SET @iIdActionEntryDelete = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_files', 'view entry', NULL, '_bx_files_acl_action_view_entry', '', 1, 0);
SET @iIdActionEntryView = LAST_INSERT_ID();

INSERT INTO `sys_acl_actions` (`Module`, `Name`, `AdditionalParamName`, `Title`, `Desc`, `Countable`, `DisabledForLevels`) VALUES
('bx_files', 'edit any entry', NULL, '_bx_files_acl_action_edit_any_entry', '', 1, 3);
SET @iIdActionEntryEditAny = LAST_INSERT_ID();

SET @iUnauthenticated = 1;
SET @iAccount = 2;
SET @iStandard = 3;
SET @iUnconfirmed = 4;
SET @iPending = 5;
SET @iSuspended = 6;
SET @iModerator = 7;
SET @iAdministrator = 8;
SET @iPremium = 9;

INSERT INTO `sys_acl_matrix` (`IDLevel`, `IDAction`) VALUES

-- entry create
(@iStandard, @iIdActionEntryCreate),
(@iModerator, @iIdActionEntryCreate),
(@iAdministrator, @iIdActionEntryCreate),
(@iPremium, @iIdActionEntryCreate),

-- entry delete
(@iStandard, @iIdActionEntryDelete),
(@iModerator, @iIdActionEntryDelete),
(@iAdministrator, @iIdActionEntryDelete),
(@iPremium, @iIdActionEntryDelete),

-- entry view
(@iUnauthenticated, @iIdActionEntryView),
(@iAccount, @iIdActionEntryView),
(@iStandard, @iIdActionEntryView),
(@iUnconfirmed, @iIdActionEntryView),
(@iPending, @iIdActionEntryView),
(@iModerator, @iIdActionEntryView),
(@iAdministrator, @iIdActionEntryView),
(@iPremium, @iIdActionEntryView),

-- edit any entry
(@iModerator, @iIdActionEntryEditAny),
(@iAdministrator, @iIdActionEntryEditAny);


-- SEARCH
SET @iSearchOrder = (SELECT IFNULL(MAX(`Order`), 0) FROM `sys_objects_search`);
INSERT INTO `sys_objects_search` (`ObjectName`, `Title`, `Order`, `ClassName`, `ClassPath`) VALUES
('bx_files', '_bx_files', @iSearchOrder + 1, 'BxFilesSearchResult', 'modules/boonex/files/classes/BxFilesSearchResult.php'),
('bx_files_cmts', '_bx_files_cmts', @iSearchOrder + 2, 'BxFilesCmtsSearchResult', 'modules/boonex/files/classes/BxFilesCmtsSearchResult.php');

-- METATAGS
INSERT INTO `sys_objects_metatags` (`object`, `table_keywords`, `table_locations`, `table_mentions`, `override_class_name`, `override_class_file`) VALUES
('bx_files', 'bx_files_meta_keywords', '', '', '', '');

-- CATEGORY
INSERT INTO `sys_objects_category` (`object`, `search_object`, `form_object`, `list_name`, `table`, `field`, `join`, `where`, `override_class_name`, `override_class_file`) VALUES
('bx_files_cats', 'bx_files', 'bx_files', 'bx_files_cats', 'bx_files_main', 'cat', 'INNER JOIN `sys_profiles` ON (`sys_profiles`.`id` = `bx_files_main`.`author`)', 'AND `sys_profiles`.`status` = ''active''', '', '');

-- GRIDS: moderation tools
INSERT INTO `sys_objects_grid` (`object`, `source_type`, `source`, `table`, `field_id`, `field_order`, `field_active`, `paginate_url`, `paginate_per_page`, `paginate_simple`, `paginate_get_start`, `paginate_get_per_page`, `filter_fields`, `filter_fields_translatable`, `filter_mode`, `sorting_fields`, `sorting_fields_translatable`, `visible_for_levels`, `override_class_name`, `override_class_file`) VALUES
('bx_files_administration', 'Sql', 'SELECT * FROM `bx_files_main` WHERE 1 ', 'bx_files_main', 'id', 'added', 'status_admin', '', 20, NULL, 'start', '', 'title,desc', '', 'like', '', '', 192, 'BxFilesGridAdministration', 'modules/boonex/files/classes/BxFilesGridAdministration.php'),
('bx_files_common', 'Sql', 'SELECT * FROM `bx_files_main` WHERE 1 ', 'bx_files_main', 'id', 'added', 'status', '', 20, NULL, 'start', '', 'title,desc', '', 'like', '', '', 2147483647, 'BxFilesGridCommon', 'modules/boonex/files/classes/BxFilesGridCommon.php');


INSERT INTO `sys_grid_fields` (`object`, `name`, `title`, `width`, `translatable`, `chars_limit`, `params`, `order`) VALUES
('bx_files_administration', 'checkbox', '_sys_select', '2%', 0, '', '', 1),
('bx_files_administration', 'switcher', '_bx_files_grid_column_title_adm_active', '8%', 0, '', '', 2),
('bx_files_administration', 'title', '_bx_files_grid_column_title_adm_title', '25%', 0, '', '', 3),
('bx_files_administration', 'added', '_bx_files_grid_column_title_adm_added', '20%', 1, '25', '', 4),
('bx_files_administration', 'author', '_bx_files_grid_column_title_adm_author', '25%', 0, '25', '', 5),
('bx_files_administration', 'actions', '', '20%', 0, '', '', 6),
('bx_files_common', 'checkbox', '_sys_select', '2%', 0, '', '', 1),
('bx_files_common', 'switcher', '_bx_files_grid_column_title_adm_active', '8%', 0, '', '', 2),
('bx_files_common', 'title', '_bx_files_grid_column_title_adm_title', '40%', 0, '', '', 3),
('bx_files_common', 'added', '_bx_files_grid_column_title_adm_added', '30%', 1, '25', '', 4),
('bx_files_common', 'actions', '', '20%', 0, '', '', 5);

INSERT INTO `sys_grid_actions` (`object`, `type`, `name`, `title`, `icon`, `icon_only`, `confirm`, `order`) VALUES
('bx_files_administration', 'bulk', 'delete', '_bx_files_grid_action_title_adm_delete', '', 0, 1, 1),
('bx_files_administration', 'single', 'edit', '_bx_files_grid_action_title_adm_edit', 'pencil', 1, 0, 1),
('bx_files_administration', 'single', 'delete', '_bx_files_grid_action_title_adm_delete', 'remove', 1, 1, 2),
('bx_files_administration', 'single', 'settings', '_bx_files_grid_action_title_adm_more_actions', 'cog', 1, 0, 3),
('bx_files_common', 'bulk', 'delete', '_bx_files_grid_action_title_adm_delete', '', 0, 1, 1),
('bx_files_common', 'single', 'edit', '_bx_files_grid_action_title_adm_edit', 'pencil', 1, 0, 1),
('bx_files_common', 'single', 'delete', '_bx_files_grid_action_title_adm_delete', 'remove', 1, 1, 2),
('bx_files_common', 'single', 'settings', '_bx_files_grid_action_title_adm_more_actions', 'cog', 1, 0, 3);

-- UPLOADERS
INSERT INTO `sys_objects_uploader` (`object`, `active`, `override_class_name`, `override_class_file`) VALUES
('bx_files_simple', 1, 'BxFilesUploaderSimple', 'modules/boonex/files/classes/BxFilesUploaderSimple.php'),
('bx_files_html5', 1, 'BxFilesUploaderHTML5', 'modules/boonex/files/classes/BxFilesUploaderHTML5.php');

-- ALERTS

INSERT INTO `sys_alerts_handlers` (`name`, `class`, `file`, `service_call`) VALUES 
('bx_files', 'BxFilesAlertsResponse', 'modules/boonex/files/classes/BxFilesAlertsResponse.php', '');
SET @iHandler := LAST_INSERT_ID();

INSERT INTO `sys_alerts` (`unit`, `action`, `handler_id`) VALUES
('system', 'save_setting', @iHandler),
('profile', 'delete', @iHandler);

-- CRON

INSERT INTO `sys_cron_jobs` (`name`, `time`, `class`, `file`, `service_call`) VALUES
('bx_files_process_data', '* * * * *', 'BxFilesCronProcessData', 'modules/boonex/files/classes/BxFilesCronProcessData.php', '');

