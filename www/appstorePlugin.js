var exec = require("cordova/exec");

function DeviceModel() { };

DeviceModel.prototype.devicePlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'checkAppOnDevice', option);
};

DeviceModel.prototype.getUUIDPlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'getAppUUIDOnDevice', option);
};

DeviceModel.prototype.setAppBadgePlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'setAppBadge', option);
};

DeviceModel.prototype.requestAuthorizationPlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'registerDevice', option);
};

DeviceModel.prototype.getRegisterTokenPlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'getDeviceToken', option);
};

DeviceModel.prototype.notifiStatusPlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'isNotificationOpen', option);
};

DeviceModel.prototype.settingPlugin = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'openSetting', option);
};

DeviceModel.prototype.onReceiveMessage = function (success, fail, option) {
    exec(success, fail, 'AppStore', 'receiveNotification', option);
};

var deviceModel = new DeviceModel();
module.exports = deviceModel;