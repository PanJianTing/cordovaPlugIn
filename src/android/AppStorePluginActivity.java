package com.digiwin.AppStore.Cordova;

import android.app.Activity;
import android.app.NotificationManager;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by panjianting on 2017/11/9.
 */

public class AppStorePluginActivity extends Activity {

    private static String TAG = "AppStorePluginActivity";


    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        Log.e(TAG, "OnCreate");

        String callBackStr = null;

        if (getIntent().getExtras() != null){
            Log.e(TAG, "User Tap Notification");
            for (String key : getIntent().getExtras().keySet()){

                if (key.equals("data")){
                    callBackStr = getIntent().getExtras().getString(key);
                }

            }
        }
        AppStorePlugin.receiveMessage = callBackStr;

        finish();
    }


    @Override
    protected void onResume() {
        super.onResume();

        Log.e(TAG, "onResume");
        final NotificationManager notificationManager = (NotificationManager) this.getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

    @Override
    public void onStart(){

        super.onStart();
        Log.e(TAG, "onStart");
    }

    @Override
    public void onStop(){

        super.onStop();
        Log.e(TAG, "onStop");
    }




}
