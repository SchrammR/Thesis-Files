using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Valve.VR;
using HTC.UnityPlugin.Vive;
using System.Text;
using System;

public class identifyTrackers : MonoBehaviour
{
    public SteamVR_TrackedObject[] trackers = new SteamVR_TrackedObject[6];

    // Start is called before the first frame update
    void Start()
    {
        StringBuilder sb = new StringBuilder();
        ETrackedPropertyError error = new ETrackedPropertyError();
        for(uint i=0; i < 16; i++)
        {
            OpenVR.System.GetStringTrackedDeviceProperty(i, ETrackedDeviceProperty.Prop_SerialNumber_String, sb, OpenVR.k_unMaxPropertyStringSize, ref error);
            Debug.Log(i);
            string s = sb.ToString();
            Debug.Log(s);

            int deviceIndex = Convert.ToInt32(i); //same behavior as checked

            if (sb.ToString().Equals("LHR-15B8F841")) trackers[0].SetDeviceIndex(deviceIndex);  //left ellbow
            if (sb.ToString().Equals("LHR-05BCCE53")) trackers[1].SetDeviceIndex(deviceIndex);  //right ellbow
            if (sb.ToString().Equals("LHR-1BBEFA90")) trackers[2].SetDeviceIndex(deviceIndex);  //left knee
            if (sb.ToString().Equals("LHR-05BE38EF")) trackers[3].SetDeviceIndex(deviceIndex);  //right knee
            if (sb.ToString().Equals("LHR-05BD178A")) trackers[4].SetDeviceIndex(deviceIndex);  //left foot
            if (sb.ToString().Equals("LHR-09B913AD")) trackers[5].SetDeviceIndex(deviceIndex);  //right foot
        }
    }

    // Update is called once per frame
    void Update()
    {

    }
}
