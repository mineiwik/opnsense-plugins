<?php

namespace OPNsense\netbird;

/**
 * Class IndexController
 * @package OPNsense\netbird
 */
class IndexController extends \OPNsense\Base\IndexController
{
    public function indexAction()
    {
        // pick the template to serve to our users.
        // fetch form data "general" in
        $this->view->generalForm = $this->getForm("general");
        $this->view->pick('OPNsense/netbird/index');
    }
}
