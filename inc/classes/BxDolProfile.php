<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    DolphinCore Dolphin Core
 * @{
 */

bx_import('BxDolProfileQuery');

define('BX_PROFILE_ACTION_AUTO', 0); ///< automatic action without any checking
define('BX_PROFILE_ACTION_MANUAL', 1); ///< manual action performed by human 
define('BX_PROFILE_ACTION_ROBOT', 2); ///< action peformed by some robot based on some conditions

class BxDolProfile extends BxDol implements iBxDolProfile {

    protected $_iProfileID;
    protected $_oQuery;

    /**
     * Constructor
     */
    protected function __construct ($iProfileId) {
        $iProfileId = (int)$iProfileId;
        $sClass = get_class($this) . '_' . $iProfileId;
        if (isset($GLOBALS['bxDolClasses'][$sClass]))
            trigger_error ('Multiple instances are not allowed for the class: ' . get_class($this), E_USER_ERROR);

        parent::__construct();

        $this->_iProfileID = $iProfileId; // since constructor is protected $iProfileId is always valid
        $this->_oQuery = BxDolProfileQuery::getInstance();
    }

    /**
     * Prevent cloning the instance
     */
    public function __clone() {
        $sClass = get_class($this) . '_' . $this->_iProfileID;
        if (isset($GLOBALS['bxDolClasses'][$sClass]))
            trigger_error('Clone is not allowed for the class: ' . get_class($this), E_USER_ERROR);
    }

    /**
     * Get singleton instance of Account Profile by account id
     */
    public static function getInstanceAccountProfile($iAccountId = false) {
        if (!$iAccountId)
            $iAccountId = getLoggedId();
        $oQuery = BxDolProfileQuery::getInstance();
        $aProfile = $oQuery->getProfileByContentTypeAccount($iAccountId, 'system', $iAccountId);
        if (!$aProfile)
            return false;
        return self::getInstance($aProfile['id']);
    }

    /**
     * Get singleton instance of Profile by account id, content id and type
     */
    public static function getInstanceByContentTypeAccount($iContent, $sType, $iAccountId = false) {
        if (!$iAccountId)
            $iAccountId = getLoggedId();
        $oQuery = BxDolProfileQuery::getInstance();
        $aProfile = $oQuery->getProfileByContentTypeAccount($iContent, $sType, $iAccountId);
        if (!$aProfile)
            return false;
        return self::getInstance($aProfile['id']);
    }

    /**
     * Get singleton instance of Profile by content id and type
     */
    public static function getInstanceByContentAndType($iContent, $sType) {
        $oQuery = BxDolProfileQuery::getInstance();
        $aProfile = $oQuery->getProfileByContentAndType($iContent, $sType);
        if (!$aProfile)
            return false;
        return self::getInstance($aProfile['id']);
    }

    /**
     * Get singleton instance of Profile by profile id
     */
    public static function getInstance($mixedProfileId = false) {

        if (!$mixedProfileId) {
            $oQuery = BxDolProfileQuery::getInstance();
            $mixedProfileId = $oQuery->getCurrentProfileByAccount(getLoggedId());
        }

        $iProfileId = self::getID($mixedProfileId);
        if (!$iProfileId)
            return false;

        $sClass = __CLASS__ . '_' . $iProfileId;
        if (!isset($GLOBALS['bxDolClasses'][$sClass]))
            $GLOBALS['bxDolClasses'][$sClass] = new BxDolProfile($iProfileId);

        return $GLOBALS['bxDolClasses'][$sClass];
    }

    /**
     * Get profile id
     */
    public function id() {
        return $this->_oQuery->getIdById($this->_iProfileID);
    }

    /**
     * Get account id associated with the profile
     */
    public function getAccountId() {
        $aInfo = $this->getInfo();
        return $aInfo['account_id'];
    }

    /**
     * Get content id associated with the profile
     */
    public function getContentId() {
        $aInfo = $this->getInfo();
        return $aInfo['content_id'];
    }

    /**
     * Check if profile status is active
     */
    public function isActive($iProfileId = false) {
        return BX_PROFILE_STATUS_ACTIVE == $this->getStatus($iProfileId);
    }

    /**
     * Get profile status
     */
    public function getStatus($iProfileId = false) {
        $aInfo = $this->_oQuery->getInfoById((int)$iProfileId ? $iProfileId : $this->_iProfileID);
        return $aInfo['status'];
    }

    /**
     * Get profile info
     */
    public function getInfo($iProfileId = 0) {
        return $this->_oQuery->getInfoById((int)$iProfileId ? $iProfileId : $this->_iProfileID);
    }

    /**
     * Validate profile id. 
     * @param $s - profile id
     * @return profile id or false if profile was not found
     */
    static public function getID($s) {
        $iId = BxDolProfileQuery::getInstance()->getIdById((int)$s);
        return $iId ? $iId : false;
    }

    /**
     * Get name to display in thumbnail
     */
    public function getDisplayName($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_name', array($aInfo['content_id']));
    }

    /**
     * Get profile url
     */
    public function getUrl($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_url', array($aInfo['content_id']));
    }

    /**
     * Get profile unit
     */
    public function getUnit($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_unit', array($aInfo['content_id']));
    }

    /**
     * Get thumbnail url
     */
    public function getAvatar($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_avatar', array($aInfo['content_id']));
    }

    /**
     * Get thumbnail url
     */
    public function getThumb($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_thumb', array($aInfo['content_id']));
    }

    /**
     * Get icon url
     */
    public function getIcon($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_icon', array($aInfo['content_id']));
    }

    /**
     * get profile edit page url
     */
    public function getEditUrl($iProfileId = 0) {
        $aInfo = $this->getInfo($iProfileId);
        return BxDolService::call($aInfo['type'], 'profile_edit_url', array($aInfo['content_id']));
    }

    /**
     * Delete profile.
     * @param $ID - optional profile id to delete
     * @param $bForceDelete - force deletetion is case of account profile deletion
     * @return false on error, or true on success
     */
    function delete($ID = false, $bForceDelete = false) {

        $ID = (int)$ID;
        if (!$ID)
            $ID = $this->_iProfileID;

        $aProfileInfo = $this->_oQuery->getInfoById($ID);
        if (!$aProfileInfo)
            return false;

        // delete system profiles (accounts) is not allowed, instead - delete whole account
        if (!$bForceDelete && 'system' == $aProfileInfo['type'])
            return false;
    
        // switch profile context if deleted profile is active profile context
        bx_import('BxDolAccount');
        $oAccount = BxDolAccount::getInstance ($aProfileInfo['account_id']);
        $aAccountInfo = $oAccount->getInfo();
        if (!$bForceDelete && $ID == $aAccountInfo['profile_id']) {
            $oProfileAccount = BxDolProfile::getInstanceAccountProfile($aProfileInfo['account_id']);
            $oAccount->updateProfileContext($oProfileAccount->id());
        }

        // create system event before deletion
        $isStopDeletion = false;
        bx_alert('profile', 'before_delete', $ID, 0, array('stop_deletion' => &$isStopDeletion));
        if ($isStopDeletion)
            return false;

        // delete associated comments
        bx_import('BxDolCmts');
        BxDolCmts::onAuthorDelete($ID);

        // delete associated content 
        // TODO: remake deletion of associated content
        $this->_oQuery->res("DELETE FROM `sys_acl_levels_members` WHERE `IDMember` = {$ID}");

        // delete profile
        if (!$this->_oQuery->delete($ID))
            return false;

        // create system event
        bx_alert('profile', 'delete', $ID);

        // unset class instance to prevent creating the instance again
        $this->_iProfileID = 0;
        $sClass = get_class($this) . '_' . $ID;
        unset($GLOBALS['bxDolClasses'][$sClass]);        

        return true;
    }

    /**
     * Insert account and content id association. Also if currect profile id is not defined - it updates current profile id in account.
     * @param $iAccountId account id
     * @param $iContentId content id
     * @param $sStatus profile status
     * @param $sType profile content type
     * @return inserted profile's id
     */
    static public function add ($iAction, $iAccountId, $iContentId, $sStatus, $sType = 'system') {
        $oQuery = BxDolProfileQuery::getInstance();
        if (!($iProfileId = $oQuery->insertProfile ($iAccountId, $iContentId, $sStatus, $sType)))
            return false;
        bx_alert('profile', 'add', $iProfileId, 0, array('module' => $sType, 'content' => $iContentId, 'account' => $iAccountId, 'status' => $sStatus, 'action' => $iAction));
        return $iProfileId;
    }

    /**
     * Change profile status from 'Pending' to the next level - 'Active'
     */
    public function approve($iAction, $iProfileId = 0) {
        if (!$iProfileId)
            $iProfileId = $this->_iProfileID;
        if (!$this->_oQuery->changeStatus($iProfileId, BX_PROFILE_STATUS_ACTIVE))
            return false;
        bx_alert('profile', 'approve', $iProfileId, false, array('action' => $iAction));
        // TODO: send email that profile is approved
        return true;
    }

    /**
     * Change profile status to 'Pending' 
     */
    public function disapprove($iAction, $iProfileId = 0) {
        if (!$this->_oQuery->changeStatus((int)$iProfileId ? $iProfileId : $this->_iProfileID, BX_PROFILE_STATUS_PENDING))
            return false;
        bx_alert('profile', 'disapprove', $iProfileId ? $iProfileId : $this->_iProfileID, false, array('action' => $iAction));
        // TODO: send email that profile is disapproved ?
        return true;
    }

    /**
     * Change profile status to 'Suspended' 
     */
    public function suspend($iAction, $iProfileId = 0) {
        if (!$this->_oQuery->changeStatus((int)$iProfileId ? $iProfileId : $this->_iProfileID, BX_PROFILE_STATUS_SUSPENDED))
            return false;
        bx_alert('profile', 'suspend', $iProfileId, false, array('action' => $iAction));
        // TODO: send email that profile is suspended
        return true;
    }


    /**
     * Display informer message if it is possible to switch to this profile
     */
    public function checkSwitchToProfile($oTemplate = null, $iViewerAccountId = false, $iViewerProfileId = false) {
        if (false === $iViewerAccountId)
            $iViewerAccountId = getLoggedId();
        if (false === $iViewerProfileId)
            $iViewerProfileId = bx_get_logged_profile_id();

        if (!$iViewerAccountId || !$iViewerProfileId)
            return;

        if ($iViewerAccountId != $this->getAccountId() ||  $iViewerProfileId == $this->id())
            return;

        bx_import('BxDolInformer');
        bx_import('BxDolPermalinks');
        $oInformer = BxDolInformer::getInstance($oTemplate);
        if ($oInformer)
            $oInformer->add('sys-switch-profile-context', _t('_sys_txt_account_profile_context_change_suggestion', BxDolPermalinks::getInstance()->permalink('page.php?i=account-profile-switcher', array('switch_to_profile' => $this->id()))), BX_INFORMER_INFO);

    }
}

/** @} */

