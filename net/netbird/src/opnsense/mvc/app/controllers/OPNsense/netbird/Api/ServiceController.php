<?php

namespace OPNsense\netbird\Api;

use OPNsense\Base\ApiMutableServiceControllerBase;
use OPNsense\Core\Backend;
use OPNsense\Core\Config;
use OPNsense\netbird\Netbird;


/**
 * Class ServiceController
 * @package OPNsense\netbird
 */
class ServiceController extends ApiMutableServiceControllerBase
{
    protected static $internalServiceClass = '\OPNsense\netbird\Netbird';
    protected static $internalServiceEnabled = 'general.Enabled';
    protected static $internalServiceTemplate = 'OPNsense/netbird';
    protected static $internalServiceName = 'netbird';

   public function constatusAction()
   {
       $backend = new Backend();
       $bckresult = $backend->configdRun("netbird con-status");
       if ($bckresult !== null) {
           return nl2br(htmlspecialchars($bckresult));
       }
   }

    public function reloadAction()
    {
        $status = "failed";
        if ($this->request->isPost()) {
            $mdlNetbird = new Netbird();
            $backend = new Backend();
            $bckresult = trim($backend->configdRun('template reload OPNsense/netbird'));
            if ($bckresult == "OK") {
                $status = "ok";
            }
            $enabled = $mdlNetbird->general->Enabled->__toString() == 1;
            $action = $enabled ? "restart" : "stop";
            $backend->configdRun("netbird $action");

        }
        return array("status" => $status);
    }
}
