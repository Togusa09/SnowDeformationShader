Shader "Unlit/CombinedDepth"
{
    Properties
    {
		_TerrainTex("Texture", 2D) = "white" {}
		_ColliderTex("Texture", 2D) = "white" {}
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
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _TerrainTex;
            float4 _TerrainTex_ST;

			sampler2D _ColliderTex;
			float4 _ColliderTex_ST;

			half _SnowHeight;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _TerrainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed colTerrain = tex2D(_TerrainTex, i.uv);
				fixed colCollider = tex2D(_ColliderTex, i.uv);
                // apply fog
//                UNITY_APPLY_FOG(i.fogCoord, col);
				//fixed col = colCollider -colTerrain;
				fixed4 col;
				col = fixed4(0, 0, 0, 1.0);
				//col.r = colCollider;
				//col.g = colTerrain;
				//col.b = (colCollider * 10) - (1 - colTerrain);
				

				//col.b = (1 - colTerrain);

				if ((colCollider.r ) > _SnowHeight) {
					//col.r = ((colCollider.r)  - colTerrain.r);
					//col.b = (1-colTerrain);
					//col.r = colCollider;
					col.r = colCollider + colTerrain;
				}

				

                return col;
            }
            ENDCG
        }
    }
}
