using AOT;
using System;
using System.Runtime.InteropServices;
#if !UNITY_EDITOR && UNITY_IOS
using UnityEngine;
#endif

public static class SwiftPmPlagin
{
#if UNITY_EDITOR_OSX
    private const string libName = "MacOsSwiftPmPlugin";
#elif UNITY_IOS
    private const string libName = "__Internal";
#endif

    // ------------------------------------------------------------------
    // Functions for iOS & macOS
    // ------------------------------------------------------------------

    [DllImport(libName)]
    private static extern long swiftPmPlugin_toNumber(string stringNumber);

    /// <summary>
    /// Convert string to long
    /// </summary>
    public static long ToNumber(string stringNumber)
    {
        return swiftPmPlugin_toNumber(stringNumber);
    }

    // ------------------------------------------------------------------

    [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
    private delegate void swiftPmPlugin_callBackType([MarshalAs(UnmanagedType.LPStr), In] string message);

    [DllImport(libName)]
    private static extern void swiftPmPlugin_callBack([MarshalAs(UnmanagedType.FunctionPtr)] swiftPmPlugin_callBackType callback);

    [MonoPInvokeCallback(typeof(swiftPmPlugin_callBackType))]
    private static void swiftPmPlugin_callBackHandler(string message)
    {
        CallBackAction(message);
    }

    /// <summary>
    /// Action on CallBack function
    /// </summary>
    public static event Action<string> CallBackAction;

    /// <summary>
    /// CallBack
    /// </summary>
    public static void CallBack()
    {
        swiftPmPlugin_callBack(swiftPmPlugin_callBackHandler);
    }

    // ------------------------------------------------------------------
    // Functions for iOS
    // ------------------------------------------------------------------

#if !UNITY_EDITOR && UNITY_IOS
    // ------------------------------------------------------------------

    [DllImport("__Internal")]
    private static extern void swiftPmPlugin_callSendMessage();

    /// <summary>
    /// Send Message Object: "Cube", Method: "Sent", Arg: "from send message"
    /// </summary>
    public static void CallSendMessage()
    {
        swiftPmPlugin_callSendMessage();
    }

    // ------------------------------------------------------------------

    [DllImport("__Internal")]
    private static extern void swiftPmPlugin_saveImage(IntPtr mtlTexture);

    public static void SaveImage(Texture texture)
    {
        swiftPmPlugin_saveImage(texture.GetNativeTexturePtr());
    }

    // ------------------------------------------------------------------

    [DllImport("__Internal")]
    private static extern void swiftPmPlugin_presentVc();

    public static void PresentVc()
    {
        swiftPmPlugin_presentVc();
    }

    // ------------------------------------------------------------------
#endif
}
