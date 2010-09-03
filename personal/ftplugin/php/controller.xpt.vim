XPTemplate priority=personal+

XPT controller-normal " Standard ActionController

class `classname^ extends \Livando_Controller_Action {

    public function indexAction() {
    }

}

XPT controller-restful " Restful ActionController

use Livando\Controller\AjaxAction,
    Livando\Rest\RestControllerInterface;

class `classname^  extends AjaxAction
    implements RestControllerInterface {

    public function deleteAction() {
    }

    public function getAction() {
    }

    public function indexAction() {
    }

    public function postAction() {
    }

    public function putAction() {
    }

    public function editAction() {
    }

    public function newAction() {
    }
}
