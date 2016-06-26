using UnityEngine;
using System.Collections;

public class StandardPulse : MonoBehaviour {

	public AnimationCurve Interpolation;
	public float Speed = 1f;

	private float TimeAccumulator = 0f;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

		TimeAccumulator += Time.deltaTime * Speed;

		float val = Interpolation.Evaluate(TimeAccumulator);

		transform.localScale = Vector3.one * val;
	
	}
}
