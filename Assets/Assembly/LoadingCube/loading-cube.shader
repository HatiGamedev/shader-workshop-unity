Shader "Workshop/Loading Cube" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_OffTex ("Unload (RGB)", 2D) = "white" {}
		_EmissionColor ("Emission Color", Color) = (1,1,1,1)

		_LoadingGradient ("Loading Gradient", 2D) = "white" {}
		_Progress ("Loading Progress", Range(-1.0, 1.0)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _OffTex;
		sampler2D _LoadingGradient;

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		fixed4 _Color;
		fixed4 _EmissionColor;
		half _Progress;

		void surf(Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 loaded = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 unloaded = tex2D (_OffTex, IN.uv_MainTex);
			
			fixed4 gradient = tex2D(_LoadingGradient, IN.uv_MainTex);
			float alpha = clamp(gradient.r + _Progress, 0, 1);

			fixed4 c = lerp(unloaded, loaded, alpha);

			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
