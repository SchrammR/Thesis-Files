using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VRMover : MonoBehaviour
{
    public Transform simulatedHMD;
    public Transform dummyHead;
    public int x, y, z = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        dummyHead.SetPositionAndRotation(simulatedHMD.position, Quaternion.Euler(x, y, z) * simulatedHMD.rotation);
    }
}
