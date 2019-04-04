using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerController : MonoBehaviour
{

    public Transform headTarget;
    public Transform leftHandTarget;
    public Transform rightHandTarget;

    public float walkSpeed = 2;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        Vector3 headTargetRotated = headTarget.forward;
        headTargetRotated = Quaternion.Euler(0, 90, 0) * headTargetRotated;
        Debug.Log(headTargetRotated);

        if(Input.GetKey("w")){
            headTarget.position += headTargetRotated * Time.deltaTime * walkSpeed;
            leftHandTarget.position += headTargetRotated * Time.deltaTime * walkSpeed;
            rightHandTarget.position += headTargetRotated * Time.deltaTime * walkSpeed;
        }
        
        if(Input.GetKey("s")){
            headTarget.position -= headTargetRotated * Time.deltaTime * walkSpeed;
            leftHandTarget.position -= headTargetRotated * Time.deltaTime * walkSpeed;
            rightHandTarget.position -= headTargetRotated * Time.deltaTime * walkSpeed;
        }
    }
}
