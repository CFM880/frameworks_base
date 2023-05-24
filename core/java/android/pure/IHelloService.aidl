package android.pure;

import android.pure.ICallback;
/** {@hide} */
interface IHelloService {
    void hello(in String name);
    void registerCallback(in int pid, in ICallback callback);
    void unregisterCallback(in int pid);
}