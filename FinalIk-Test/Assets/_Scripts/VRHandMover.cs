using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VRHandMover : MonoBehaviour
{
    public Transform HMDHand;
    public Transform DummyHand;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        DummyHand.SetPositionAndRotation(HMDHand.position, HMDHand.rotation);
    }
}
