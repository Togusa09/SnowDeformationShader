Shader "Unlit/SnowCombiner"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
		_CollisionsTex("Collisions", 2D) = "black" {}
		_Offset("Offset", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
 

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
				float2 uvSnow : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
				float2 uvSnow : TEXCOORD1;

                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			sampler _CollisionsTex;
			float4 _CollisionsTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvSnow = TRANSFORM_TEX(v.uvSnow, _CollisionsTex);
				//o.uv = (tex.xy * name##_ST.xy + name##_ST.zw)
                return o;
            }

            fixed frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 colSnow = tex2D(_CollisionsTex, i.uvSnow);

				fixed c = max(col.r, colSnow.r);


				return c;
            }
            ENDCG
        }
    }
}
