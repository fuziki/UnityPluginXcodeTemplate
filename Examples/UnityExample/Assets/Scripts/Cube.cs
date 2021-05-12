using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class Cube : MonoBehaviour
{

#if UNITY_EDITOR_OSX
    [DllImport("MacOsSwiftPmPlugin")]
#elif UNITY_IOS
    [DllImport("__Internal")]
#endif
    private static extern long swiftPmPlugin_toNumber(string stringNumber);

    private int counter = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        this.transform.Rotate(new Vector3(1, 1, 1));

        counter++;

        Debug.Log("counter: " + swiftPmPlugin_toNumber(counter.ToString()));

    }
}
