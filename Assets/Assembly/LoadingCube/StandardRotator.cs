using UnityEngine;
using System.Collections;

public class StandardRotator : MonoBehaviour {

	public Vector3 EulerAngles = Vector3.one;
	public float Speed = 1.0f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.localRotation = transform.localRotation * Quaternion.Euler(EulerAngles * Speed * Time.deltaTime);
	
	}
}
