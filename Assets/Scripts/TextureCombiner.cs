using UnityEngine;


//[ExecuteInEditMode]
public class TextureCombiner : MonoBehaviour
{
    public Texture TerrainTexture;
    public Texture ColliderTexture;

    public GameObject CameraParent;
    public Drawable TerrainDrawable;
    public Material SnowDrawMaterial;

    public float SnowHeight = 0.9f;

    private RenderTexture _Temp;

    // Start is called before the first frame update
    void Start()
    {
        _Temp = new RenderTexture(1024, 1024, 16);
    }

    // Update is called once per frame
    void Update()
    {
        var offset = ( TerrainDrawable.transform.position- CameraParent.transform.position) / 20.0f;
        SnowDrawMaterial.SetTexture("_ColliderTex", ColliderTexture);
        SnowDrawMaterial.SetTexture("_TerrainTex", TerrainTexture);
        SnowDrawMaterial.SetFloat("_SnowHeight", SnowHeight);
        //SnowDrawMaterial.SetVector("_Offset", offset);

        SnowDrawMaterial.SetTextureOffset("_ColliderTex",  new Vector2(1 + offset.x, -offset.z));

        Graphics.Blit(TerrainDrawable.SnowImpactTexture, _Temp, SnowDrawMaterial);
        Graphics.Blit(_Temp, TerrainDrawable.SnowImpactTexture);
    }
}
