using System.Collections;
using System.Collections.Generic;
using UnityEngine;


//[ExecuteInEditMode]
public class TextureCombiner : MonoBehaviour
{
    public Texture TerrainTexture;
    public Texture ColliderTexture;

    public Material CombinerMaterial;
    public RenderTexture RenderTexture;

    public GameObject CameraParent;
    public Drawable TerrainDrawable;
    public Material SnowDrawMaterial;

    public float SnowHeight = 0.9f;

    private RenderTexture _Temp;
    private Texture2D _Source;


    // Start is called before the first frame update
    void Start()
    {
        _Temp = new RenderTexture(1024, 1024, 16);
        _Source = new Texture2D(1024, 1024);
    }

    // Update is called once per frame
    void Update()
    {
        CombinerMaterial.SetTexture("_TerrainTex", TerrainTexture);
        CombinerMaterial.SetTexture("_ColliderTex", ColliderTexture);
        CombinerMaterial.SetFloat("_SnowHeight", SnowHeight);

        Graphics.Blit(_Source, RenderTexture, CombinerMaterial);

        var offset = CameraParent.transform.position - TerrainDrawable.transform.position;
        SnowDrawMaterial.SetTexture("_CollisionsTex", RenderTexture);
        
        Graphics.Blit(TerrainDrawable.SnowImpactTexture, _Temp, SnowDrawMaterial);
        Graphics.Blit(_Temp, TerrainDrawable.SnowImpactTexture);
    }
}
