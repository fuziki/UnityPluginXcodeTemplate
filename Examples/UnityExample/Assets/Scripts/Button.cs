using System;
using System.Runtime.InteropServices;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Button : MonoBehaviour
{
#if UNITY_IOS
    [DllImport("__Internal")]
    private static extern void swiftPmPlugin_saveImage(IntPtr mtlTexture);
#endif

    public RenderTexture texture;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void onTap()
    {
        Debug.Log("Button tapped!");

#if UNITY_IOS
        swiftPmPlugin_saveImage(texture.GetNativeTexturePtr());
#endif
    }
}
