using UnityEngine;


//[ExecuteInEditMode]
public class TextureCombiner : MonoBehaviour
{
    public Texture TerrainTexture;
    public Texture ColliderTexture;

    public GameObject CameraParent;
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
        var cameraCollider = CameraParent.GetComponent<BoxCollider>();
        LayerMask mask = LayerMask.GetMask("Terrain");
        var terrainColliders = Physics.OverlapBox(cameraCollider.center, cameraCollider.extents, cameraCollider.transform.rotation, mask);

        foreach (var terrainCollider in terrainColliders)
        {
            var terrain = terrainCollider.GetComponent<Drawable>();

            var offset = (terrain.transform.position - CameraParent.transform.position) / 20.0f;
            SnowDrawMaterial.SetTexture("_ColliderTex", ColliderTexture);
            SnowDrawMaterial.SetTexture("_TerrainTex", TerrainTexture);
            SnowDrawMaterial.SetFloat("_SnowHeight", SnowHeight);

            SnowDrawMaterial.SetTextureOffset("_ColliderTex", new Vector2(1 + offset.x, -offset.z));
            //SnowDrawMaterial.SetTextureOffset("_TerrainTex", new Vector2(1 + offset.x, -offset.z));

            Graphics.Blit(terrain.SnowImpactTexture, _Temp, SnowDrawMaterial);
            Graphics.Blit(_Temp, terrain.SnowImpactTexture);
        }
    }
}
