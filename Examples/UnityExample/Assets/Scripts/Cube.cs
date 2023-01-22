using UnityEngine;

public class Cube : MonoBehaviour
{
    [SerializeField]
    private RenderTexture texture;

    private int counter = 0;

    // Start is called before the first frame update
    void Start()
    {
        SwiftPmPlugin.CallBackAction += (string message) =>
        {
            Debug.Log("Receive Message: " + message);
        };
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(1, 1, 1));

        counter++;

        Debug.Log($"Counter: { SwiftPmPlugin.ToNumber(counter.ToString()) }");

        Debug.Log("Call SwiftPmPlugin.CallBack()");

        SwiftPmPlugin.CallBack();

#if !UNITY_EDITOR && UNITY_IOS
        SwiftPmPlugin.CallSendMessage();
#endif
    }

    public void Sent(string message)
    {
        Debug.Log("Receive SendMessage: " + message);
    }

    public void SaveImage()
    {
        Debug.Log("Save Image!");
#if !UNITY_EDITOR && UNITY_IOS
        SwiftPmPlugin.SaveImage(texture);
#endif
    }

    public void PresentVC()
    {
        Debug.Log("Present VC!");
#if !UNITY_EDITOR && UNITY_IOS
        SwiftPmPlugin.PresentVc();
#endif
    }
}
