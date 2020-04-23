Shader "Custom/SnowShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SnowTex("Snow Impact", 2D) = "black" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
 
			
		[Toggle] _DebugRender("Debug Render", Float) = 0

		_Tess("Tessellation", Range(1,32)) = 4
		_Displacement("Displacement", Range(0, 1.0)) = 0.3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard addshadow fullforwardshadows addshadow vertex:disp tessellate:tessFixed
		#pragma require tessellation tessHW

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 4.6

		#include "MyTessellation.cginc"

        sampler2D _MainTex;
		sampler2D _SnowTex;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_SnowTex;
        };

		struct appdata {
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1: TEXCOORD1;
		};

		float _Tess;

		float4 tessFixed()
		{
			return _Tess;
		}

		float _Displacement;
		float _DebugRender;

		void disp(inout appdata v)
		{
			float d = (1 - tex2Dlod(_SnowTex, float4(v.texcoord1.xy, 0, 0)).r) * _Displacement;
			v.vertex.xyz += normalize(v.normal) * d;
		}

	    half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

		float3 normalize(float3 v) {
			return rsqrt(dot(v, v)) * v;
		}

        void surf (Input IN, inout SurfaceOutputStandard  o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 mc = tex2D (_MainTex, IN.uv_MainTex);
			fixed sc = tex2D(_SnowTex, IN.uv_SnowTex);
			

			//if (_DebugRender) {
				//fixed4 c = lerp(mc * _Color, mc , step(sc, 0.5));
				//o.Albedo = c.rgb;
				o.Albedo = mc;
			/*}
			else {
				o.Albedo = mc.rgb;
				float3 wn = normalize(WorldNormalVector(IN, float3(0, 0, 1)));
			}*/

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
