using UnityEngine;
using System.Collections;

public class ChangeMaterialFloatValue : MonoBehaviour {

	public int MaterialIdx = 0;
	public string ShaderVariableName;

	// Hash ID of VariableName
	private int ShaderVariablePropertyId;

	public AnimationCurve Interpolation;
	[Range(0.01f, 10f)]
	public float Speed = 1f;

	public float Offset = 0f;

	private float TimeAccumulator;
	private new Renderer renderer;


	// Use this for initialization
	void Start () {

		TimeAccumulator = Offset;

		ShaderVariablePropertyId = Shader.PropertyToID(ShaderVariableName);
		renderer = GetComponent<Renderer>();
		if (!renderer.materials[MaterialIdx].HasProperty(ShaderVariablePropertyId)) throw new System.ArgumentException(ShaderVariableName + " is not a proper property in " + renderer.material);


	}
	
	void Update () {
		TimeAccumulator += Time.deltaTime * Speed;
		float interpolationResult = Interpolation.Evaluate(TimeAccumulator);

		renderer.materials[MaterialIdx].SetFloat(ShaderVariablePropertyId, interpolationResult);
	}
}
