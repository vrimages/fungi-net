﻿// Add script to quad and assign material with shader. Play.

using UnityEngine;

public class NotAnts : MonoBehaviour
{
    public int Resolution = 1024;
    public Material material;
    RenderTexture RTA1, RTA2, RTB1, RTB2;
    bool swap = true;

    void Blit(RenderTexture source, RenderTexture destination, Material mat, string name, int pass)
    {
        RenderTexture.active = destination;
        mat.SetTexture(name, source);
        GL.PushMatrix();
        GL.LoadOrtho();
        GL.invertCulling = true;
        mat.SetPass(pass);
        GL.Begin(GL.QUADS);
        GL.MultiTexCoord2(0, 0.0f, 0.0f);
        GL.Vertex3(0.0f, 0.0f, 0.0f);
        GL.MultiTexCoord2(0, 1.0f, 0.0f);
        GL.Vertex3(1.0f, 0.0f, 0.0f);

        GL.MultiTexCoord2(0, 1.0f, 1.0f);
        GL.Vertex3(1.0f, 1.0f, 1.0f);
        GL.MultiTexCoord2(0, 0.0f, 1.0f);
        GL.Vertex3(0.0f, 1.0f, 0.0f);

        GL.End();
        GL.invertCulling = false;
        GL.PopMatrix();
    }

    void Start()
    {
        RTA1 = new RenderTexture(Resolution, Resolution, 0, RenderTextureFormat.ARGBFloat);  //buffer must be floating point RT
        RTA2 = new RenderTexture(Resolution, Resolution, 0, RenderTextureFormat.ARGBFloat);  //buffer must be floating point RT
        RTB1 = new RenderTexture(Resolution, Resolution, 0, RenderTextureFormat.ARGBFloat);  //buffer must be floating point RT
        RTB2 = new RenderTexture(Resolution, Resolution, 0, RenderTextureFormat.ARGBFloat);  //buffer must be floating point RT
        GetComponent<Renderer>().material = material;
    }

    void Update()
    {
        /*
		RaycastHit hit;
		if (Input.GetMouseButton(0))
		{
			if (Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition) , out hit))
				material.SetVector("iMouse", new Vector4(
					hit.textureCoord.x * Resolution, hit.textureCoord.y * Resolution,
					Mathf.Sign(System.Convert.ToSingle(Input.GetMouseButton(0))),
					Mathf.Sign(System.Convert.ToSingle(Input.GetMouseButton(1)))));
		}
		else
		{
			material.SetVector("iMouse", new Vector4(0.0f, 0.0f, -1.0f, -1.0f));
		}
		*/

        material.SetInt("iFrame", Time.frameCount);

        //material.SetVector("iResolution", new Vector4(Resolution,Resolution,0.0f,0.0f));


        if (swap)
        {
            material.SetTexture("_BufferA2", RTA1);
            Blit(RTA1, RTA2, material, "_BufferA2", 0);
            material.SetTexture("_BufferA2", RTA2);

            material.SetTexture("_BufferB2", RTB1);
            Blit(RTB1, RTB2, material, "_BufferB2", 1);
            material.SetTexture("_BufferB2", RTB2);

        }
        else
        {
            material.SetTexture("_BufferA2", RTA2);
            Blit(RTA2, RTA1, material, "_BufferA2", 0);
            material.SetTexture("_BufferA2", RTA1);

            material.SetTexture("_BufferB2", RTB2);
            Blit(RTB2, RTB1, material, "_BufferB2", 1);
            material.SetTexture("_BufferB2", RTB1);

        }
        swap = !swap;
    }

    void OnDestroy()
    {
        RTA1.Release();
        RTA2.Release();
        RTB1.Release();
        RTB2.Release();

    }
}