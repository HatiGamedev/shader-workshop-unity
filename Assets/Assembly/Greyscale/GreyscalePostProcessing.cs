using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class GreyscalePostProcessing : MonoBehaviour {

	public Shader NewShader;
	private Shader UsingShader;
	private Material material;

	public float Intensity;

	// Use this for initialization
	void Awake()
	{
		if(NewShader != null)
		{
			InitMaterial();
		}
	}
	
	void InitMaterial()
	{
		UsingShader = NewShader;
		material = new Material(UsingShader);
	}

	// Update is called once per frame
	void Update () {
		if(NewShader != UsingShader)
		{
			InitMaterial();
		}
	
	}

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		if (Intensity == 0 && UsingShader == null)
		{
			Graphics.Blit(src, dst);
			return;
		}

		material.SetFloat("_Intensity", Intensity);
		Graphics.Blit(src, dst, material);
	}
}
