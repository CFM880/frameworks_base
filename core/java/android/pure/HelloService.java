/*
 * Copyright (C) 2023 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.pure;

import android.annotation.Nullable;
import android.annotation.SystemService;
import android.os.RemoteException;
import android.util.Log;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;


/**
 * @hide
 */
@SystemService("HelloService")
public class HelloService extends IHelloService.Stub{
    private static final String TAG = "HelloService";
    private Map<Integer, ICallback> mClients;

    public HelloService() {
        Log.d(TAG, "create HelloService");
        mClients = new HashMap<>();
    }

    @Override
    public void hello(@Nullable String name) throws RemoteException{
        Log.d(TAG, "hello "+name);
        try {
            Collection<ICallback> values = mClients.values();
            for (ICallback callback : values) {
                callback.onMessage("message for service " + name);
            }
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void registerCallback(int pid, ICallback callback) throws RemoteException {
        mClients.put(pid, callback);
        Log.d(TAG, "registerCallback client's size = " + mClients.size());
    }
    @Override
    public void unregisterCallback(int pid) throws RemoteException {
        mClients.remove(pid);
        Log.d(TAG, "registerCallback client's size = " + mClients.size());
    }
}
