using UnityEngine;
using System.Collections;

public class MirrorCamera : MonoBehaviour 
{
	public Camera VrEye;
	public bool CopyClearSettings = true;
	public int TextureSize = 2048;

    private Camera cameraForPortal;
    private RenderTexture leftEyeRenderTexture;
    private RenderTexture rightEyeRenderTexture;
    private Vector3 mirrorMatrixScale = new Vector3 (-1f, 1f, 1f);
    private Vector3 reflectionRotation = new Vector3 (0f, 180f, 0f);
    private Vector3 eyeOffset;

    private Transform mirrorCameraParent;
	private Transform reflectionTransform;
	private bool renderAsMirror = true;

	private void Awake()
	{
		mirrorCameraParent = gameObject.transform.parent;
		reflectionTransform = mirrorCameraParent.parent;

		cameraForPortal = GetComponent<Camera>();
		cameraForPortal.enabled = false;

		leftEyeRenderTexture = new RenderTexture (TextureSize, TextureSize, 24);
		rightEyeRenderTexture = new RenderTexture (TextureSize, TextureSize, 24);

		if (CopyClearSettings)
		{
			cameraForPortal.clearFlags = VrEye.clearFlags;
			cameraForPortal.backgroundColor = VrEye.backgroundColor;
		}

	}

	private Matrix4x4 HMDMatrix4x4ToMatrix4x4(Valve.VR.HmdMatrix44_t input) 
	{
	    Matrix4x4 m = Matrix4x4.identity;

		m[0, 0] = input.m0;
		m[0, 1] = input.m1;
		m[0, 2] = input.m2;
		m[0, 3] = input.m3;

		m[1, 0] = input.m4;
		m[1, 1] = input.m5;
		m[1, 2] = input.m6;
		m[1, 3] = input.m7;

		m[2, 0] = input.m8;
		m[2, 1] = input.m9;
		m[2, 2] = input.m10;
		m[2, 3] = input.m11;

		m[3, 0] = input.m12;
		m[3, 1] = input.m13;
		m[3, 2] = input.m14;
		m[3, 3] = input.m15;

		return m;
	}

	public void RenderIntoMaterial(Material material) 
	{
	    if (VrEye == null)
	    {
	        VrEye = Camera.main;
	        return;
	    }
	    
		if (Camera.current == VrEye) 
		{
			if (renderAsMirror) 
			{
				reflectionTransform.localPosition = Vector3.zero;
				reflectionTransform.localRotation = Quaternion.identity;
				mirrorCameraParent.position = VrEye.transform.position;
				mirrorCameraParent.rotation = VrEye.transform.rotation;
				reflectionTransform.localEulerAngles = reflectionRotation;

				Vector3 centerAnchorPosition = mirrorCameraParent.localPosition;
				centerAnchorPosition.x *= -1;
				Vector3 centerAnchorRotation = -mirrorCameraParent.localEulerAngles;
				centerAnchorRotation.x *= -1;
				mirrorCameraParent.localPosition = centerAnchorPosition;
				mirrorCameraParent.localEulerAngles = centerAnchorRotation;
			}

			transform.localRotation = VrEye.transform.localRotation;

			if (renderAsMirror)
			{
				GL.invertCulling = true;
			}
		    
			// left eye
			if (renderAsMirror)
			{
				eyeOffset = Valve.VR.SteamVR.instance.eyes [0].pos;
				transform.localPosition = VrEye.transform.localPosition + VrEye.transform.TransformVector (eyeOffset);
				cameraForPortal.projectionMatrix = HMDMatrix4x4ToMatrix4x4 (Valve.VR.SteamVR.instance.hmd.GetProjectionMatrix (Valve.VR.EVREye.Eye_Left, VrEye.nearClipPlane, VrEye.farClipPlane)) * Matrix4x4.Scale (mirrorMatrixScale);
			}
			else
			{
				eyeOffset = Valve.VR.SteamVR.instance.eyes [0].pos;
				transform.localPosition = VrEye.transform.localPosition + VrEye.transform.TransformVector (eyeOffset);
				cameraForPortal.projectionMatrix = HMDMatrix4x4ToMatrix4x4 (Valve.VR.SteamVR.instance.hmd.GetProjectionMatrix (Valve.VR.EVREye.Eye_Left, VrEye.nearClipPlane, VrEye.farClipPlane));
			}
		    
			cameraForPortal.targetTexture = leftEyeRenderTexture;
			cameraForPortal.Render();
			material.SetTexture("_LeftEyeTexture", leftEyeRenderTexture);

			// right eye
			if (renderAsMirror)
			{
				eyeOffset = Valve.VR.SteamVR.instance.eyes [1].pos;
				transform.localPosition = VrEye.transform.localPosition + VrEye.transform.TransformVector (eyeOffset);
				cameraForPortal.projectionMatrix = HMDMatrix4x4ToMatrix4x4 (Valve.VR.SteamVR.instance.hmd.GetProjectionMatrix (Valve.VR.EVREye.Eye_Right, VrEye.nearClipPlane, VrEye.farClipPlane)) * Matrix4x4.Scale (mirrorMatrixScale);
			}
			else
			{
				eyeOffset = Valve.VR.SteamVR.instance.eyes [1].pos;
				transform.localPosition = VrEye.transform.localPosition + VrEye.transform.TransformVector (eyeOffset);
				cameraForPortal.projectionMatrix = HMDMatrix4x4ToMatrix4x4 (Valve.VR.SteamVR.instance.hmd.GetProjectionMatrix (Valve.VR.EVREye.Eye_Right, VrEye.nearClipPlane, VrEye.farClipPlane));
			}

			cameraForPortal.targetTexture = rightEyeRenderTexture;
			cameraForPortal.Render();
			material.SetTexture("_RightEyeTexture", rightEyeRenderTexture);

			if (renderAsMirror)
			{
				GL.invertCulling = false;
			}
		}
	}
}