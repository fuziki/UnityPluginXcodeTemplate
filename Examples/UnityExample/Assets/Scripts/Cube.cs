using AOT;
using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class Cube : MonoBehaviour
{

    //============================================================================
#if UNITY_EDITOR_OSX
    [DllImport("MacOsSwiftPmPlugin")]
#elif UNITY_IOS
    [DllImport("__Internal")]
#endif
    private static extern long swiftPmPlugin_toNumber(string stringNumber);

    //============================================================================

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    private delegate void swiftPmPlugin_callBackType([MarshalAs(UnmanagedType.LPStr), In] string message);

    [DllImport("__Internal")]
    private static extern void swiftPmPlugin_callBack([MarshalAs(UnmanagedType.FunctionPtr)] swiftPmPlugin_callBackType callback);

    //----------------------------------------------------------------------------

    [MonoPInvokeCallback(typeof(swiftPmPlugin_callBackType))]
    private static void swiftPmPlugin_callBackHandler(string message)
    {
        Debug.Log("native message -> " + message);
        swiftPmPlugin_callBackAction(message);
    }

    private static event Action<string> swiftPmPlugin_callBackAction;

    //============================================================================

    private int counter = 0;

    private string myMessage = "";

    // Start is called before the first frame update
    void Start()
    {
        swiftPmPlugin_callBackAction = (string message) =>
        {
            Debug.Log("set myMessage -> " + message);
            this.myMessage = message;
        };
    }

    // Update is called once per frame
    void Update()
    {
        this.transform.Rotate(new Vector3(1, 1, 1));

        counter++;

        Debug.Log("counter: " + swiftPmPlugin_toNumber(counter.ToString()));

        Debug.Log("call swiftPmPlugin_callBack(swiftPmPlugin_callBackHandlerEntry);");

        swiftPmPlugin_callBack(swiftPmPlugin_callBackHandler);

        Debug.Log("myMessage -> " + myMessage);
    }
}
