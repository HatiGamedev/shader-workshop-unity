using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class OnRenderImageBlitUsingMaterial : MonoBehaviour {

	public Material material;

	void OnRenderImage(RenderTexture src, RenderTexture dst)
	{
		Graphics.Blit(src, dst, material);
	}
}
