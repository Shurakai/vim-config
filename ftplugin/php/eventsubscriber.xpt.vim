XPTemplate priority=personal+

XPT eventsubscriber " Core of a class for EventSubscribers
<?php

namespace `namespace^;

use \Doctrine\Common\EventArgs;

class `classname^ implements \Doctrine\Common\EventSubscriber {

    public function __construct() {

    }

    public function getSubscribedEvents() {
        return array(`eventsubscribedto^);
    }
}
