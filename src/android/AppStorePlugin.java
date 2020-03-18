package com.digiwin.AppStore.Cordova;

import android.app.Activity;
import android.content.Intent;
import android.provider.Settings;
import android.support.v4.app.NotificationManagerCompat;
import android.util.Log;
import android.widget.Toast;
import com.digiwin.appstore.device.Device;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.messaging.FirebaseMessaging;


import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

import java.lang.reflect.Array;


public class AppStorePlugin extends CordovaPlugin {

    private static String logTag = "AppStorePlugin";

    public static  String receiveMessage = null;

    public AppStorePlugin() {
    }

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);

        Log.e(logTag, "initialize");
        final Activity cordovaActivity = this.cordova.getActivity();
        // User Tap Notification
        if (cordovaActivity.getIntent().getExtras() != null) {
            for (String key : cordovaActivity.getIntent().getExtras().keySet()) {

                if (key.equals("data")) {
                    receiveMessage = cordovaActivity.getIntent().getExtras().getString(key);
                    Log.e(logTag, cordovaActivity.getIntent().getExtras().getString(key));
                }

            }
        }
    }


    
    @Override
    public boolean execute(final String action, final JSONArray data, final CallbackContext callbackContext) throws JSONException {

        final Activity cordovaActivity = this.cordova.getActivity();
        Log.e(logTag, "Excute");
        Log.e(logTag, action.toString());

        if (action.equals("checkAppOnDevice")) {
            Log.e(logTag, "CheckAppOnDevice");


//            Toast.makeText(cordovaActivity, "checkAppOnDevice", Toast.LENGTH_LONG).show();

            final String appID = data.getString(0);


            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                try {

                    JSONArray appInfoArray = Device.checkAppInstall(cordovaActivity.getPackageManager(), data);

                    callbackContext.success(appInfoArray);

                } catch (Exception ex) {
                    callbackContext.error(ex.getMessage());
                }

                }
            });

            return true;

        } else if (action.equals("getAppUUIDOnDevice")) {

//            Toast.makeText(cordovaActivity, "getAppUUIDOnDevice", Toast.LENGTH_LONG).show();

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    try {
                        final String uuid = Device.getUuid(cordovaActivity.getApplication().getApplicationContext());

                        callbackContext.success(String.valueOf(uuid));
                    } catch (Exception ex) {
                        callbackContext.error(ex.getMessage());
                    }

                }
            });

            return true;
        } else if (action.equals("setAppBadge")) {

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    try {

                    } catch (Exception ex) {
                        callbackContext.error(ex.getMessage());
                    }

                }
            });

            return true;

        } else if (action.equals("registerDevice")) {

//            Toast.makeText(this.cordova.getActivity(), "registerDevice", Toast.LENGTH_LONG).show();

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    try {

                        // String token = FirebaseInstanceId.getInstance().getToken();

                        callbackContext.success(String.valueOf(true));
                    } catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }

                }
            });

            return true;

        } else if (action.equals("isNotificationOpen")) {

//            Toast.makeText(this.cordova.getActivity(), "isNotificationOpen", Toast.LENGTH_LONG).show();

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    try {

                        boolean isOpen = NotificationManagerCompat.from(cordovaActivity.getApplicationContext()).areNotificationsEnabled();


                        callbackContext.success(String.valueOf(isOpen));
                    } catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }

                }
            });

            return true;

        } else if (action.equals("openSetting")) {
//            Toast.makeText(this.cordova.getActivity(), "openSetting", Toast.LENGTH_LONG).show();

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    try {

                        cordovaActivity.startActivityForResult(new Intent(Settings.ACTION_SETTINGS), 0);

                        callbackContext.success(String.valueOf(true));
                    } catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }

                }
            });
            return true;
        } else if (action.equals("receiveNotification")) {
//            Toast.makeText(this.cordova.getActivity(), "receiveMessage", Toast.LENGTH_LONG).show();

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    
                    
                    try {
                        
                        if (receiveMessage != null){
                            callbackContext.success(String.valueOf(receiveMessage));
                        }else{
                            callbackContext.error("No Message");
                        }
                        
                    } catch (Exception e) {

                        callbackContext.error(e.getMessage());

                    }
                }
            });

            return true;

        } else if (action.equals("getDeviceToken")){

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    try {

                        String token = FirebaseInstanceId.getInstance().getToken();

                        callbackContext.success(token);
                    } catch (Exception e) {
                        callbackContext.error(e.getMessage());
                    }

                }
            });
            return true;

        } else {
            return false;
        }
    }
}
