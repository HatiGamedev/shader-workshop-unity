Shader "Workshop/Distort"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MaskTex("CRT Mask texture", 2D) = "white" {}
		_maskBlend("Mask blending", Float) = 0.5
		_maskSize("Mask Size", Float) = 1
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct input
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct vertOut
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			vertOut vert (input v)
			{
				vertOut o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _MaskTex;
			half _maskBlend;

			fixed4 frag (vertOut i) : SV_Target
			{
				half2 n = tex2D(_MaskTex, i.uv); //direction of distortion
				half2 d = n * 2 - 1; // map direction [0..1] -> [-1..1]
				i.uv += d * _maskBlend;	// distort UV by _maskBlend (Strenght)
				i.uv = saturate(i.uv); // clamp

				float4 c = tex2D(_MainTex, i.uv); //calculate real value
				return c;
			}
			ENDCG
		}
	}
}
