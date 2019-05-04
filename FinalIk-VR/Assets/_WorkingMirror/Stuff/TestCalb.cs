using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestCalb : MonoBehaviour
{
    public Transform FaceTarget;
    public Transform HMD;

    public Transform Avatar;

    private float heightEyeOne;

    private void Start()
    {
        heightEyeOne = FaceTarget.position.y;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.C))
        {
            Calibrate();
        }
    }

    void Calibrate()
    {
        float scalar =  HMD.position.y/heightEyeOne;

        Avatar.localScale =Vector3.one*  scalar;
    }
}
