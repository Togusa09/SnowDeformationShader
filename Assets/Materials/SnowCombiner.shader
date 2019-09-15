Shader "Unlit/SnowCombiner"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "black" {}
		_ColliderTex("Colliders", 2D) = "black" {}
		_TerrainTex("Terrain", 2D) = "white" {}
		_Offset("Offset", Vector) = (0, 0, 0, 0)
		_SnowHeight("Snow Height", Range(0,1)) = 0.0
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
				float2 uvCollider : TEXCOORD1;
				float2 uvTerrain: TEXCOORD2;
            };

            struct v2f
            {
				float4 vertex : SV_POSITION;

                float2 uv : TEXCOORD0;
				float2 uvCollider : TEXCOORD1;
				float2 uvTerrain: TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

			sampler _ColliderTex;
			float4 _ColliderTex_ST;

			sampler _TerrainTex;
			float4 _TerrainTex_ST;

			half _SnowHeight;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvCollider = TRANSFORM_TEX(v.uvCollider, _ColliderTex);
				o.uvTerrain = TRANSFORM_TEX(v.uvTerrain, _TerrainTex);
                return o;
            }

            fixed frag (v2f i) : SV_Target
            {
				fixed colTerrain = tex2D(_TerrainTex, i.uvTerrain);
				fixed colCollider = tex2D(_ColliderTex, i.uvCollider);


				fixed4 colCombined;
				colCombined = fixed4(0, 0, 0, 1.0);



				if ((colCollider.r) > _SnowHeight) {
					colCombined.r = colCollider + colTerrain;
				}

				fixed4 col = tex2D(_MainTex, i.uv);				

				fixed c = max(col.r, colCombined.r);
				return c;
            }
            ENDCG
        }
    }
}
