package com.digiwin.AppStore.Cordova;

import android.util.Log;

import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

/**
 * Created by panjianting on 2017/11/8.
 */

public class NotificationInstanceIDService extends FirebaseInstanceIdService {


    private  static final String TAG = "NotificationInstanceID";


    @Override
    public void onTokenRefresh(){

        String refreshToken = FirebaseInstanceId.getInstance().getToken();
        Log.e(TAG, "Refresh Token :" + refreshToken);
    }

}
