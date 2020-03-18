package com.digiwin.AppStore.Cordova;

import android.util.Log;
import android.widget.Toast;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.security.Key;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by panjianting on 2017/11/8.
 */

public class NotificationReceiveMessageService extends FirebaseMessagingService {

    private  static final String TAG = "NotificationReceive";

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage){

        Log.e(TAG, "RemoteMessage :" + remoteMessage.getData());
        Log.e(TAG, "RemoteMessage :" + remoteMessage.getNotification().getTitle());
        Log.e(TAG, "RemoteMessage :" + remoteMessage.getNotification().getBody());
        Log.e(TAG, "RemoteMessage :" + remoteMessage.getNotification().getClickAction());

        String callbackStr = null;

        Map<String, Object> data = new HashMap<String, Object>();
        for (String key : remoteMessage.getData().keySet()){
            if (key.equals("data")){
                callbackStr = remoteMessage.getData().get(key);
            }
        }

        AppStorePlugin.receiveMessage = callbackStr;
    }
}
