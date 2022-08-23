using System;
using System.Collections;
using System.Collections.Generic;
using FlutterUnityIntegration;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    // Start is called before the first frame update

    public Button headerButton;
    
    private bool prevText = false;
    
    void Start()
    {
        gameObject.AddComponent<UnityMessageManager>();
        headerButton.onClick.AddListener(ChangeFlutterText);
    }

    // Update is called once per frame
    void Update()
    { }

    void HandleWebFnCall(String action)
    {
        switch (action)
        {
            case "pause":
                Time.timeScale = 0;
                break;
            case "resume":
                Time.timeScale = 1;
                break;
            case "unload":
                Application.Unload();
                break;
            case "quit":
                Application.Quit();
                break;
        }
    }

    public void MessageFlutter(String name, object data)
    {
        var o = JObject.FromObject(new
        {
            type = name,
            data = data
        });
        UnityMessageManager.Instance.SendMessageToFlutter(o.ToString());
    }

    void SwitchScene(String message)
    {
        SceneManager.LoadScene(message);
    }

    void ChangeFlutterText()
    {
        var message = "";
        if (prevText)
        {
            message = "Oh Dear, it's working";
            MessageFlutter("ChangeHeaderText", message);
            prevText = false;
            return;
        }

        message = "Oh Boy, it's new message";
        MessageFlutter("ChangeHeaderText", message);
        prevText = true;
    }
}
